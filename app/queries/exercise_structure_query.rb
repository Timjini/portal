# frozen_string_literal: true

class ExerciseStructureQuery # rubocop:disable Metrics/ClassLength
  def initialize
    @structured_data = {}
  end

  def call
    @query = execute_query
    structure_data
    @structured_data
  # rescue Errors::QueryError => e
  #   { error: e.message }
  end

  private

  def execute_query # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    # begin # rubocop:disable Style/RedundantBegin
      verify_database_connection!
      sql = build_structure_query
      QUERY_LOGGER.info('Executing structure query')

      result = with_query_timeout(10) do
        ActiveRecord::Base.connection.exec_query(sql)
      end

      validate_query_result(result)
      result
    # rescue ActiveRecord::ConnectionNotEstablished => e
    #   log_and_reconnect(e)
    #   retry
    # rescue ActiveRecord::StatementInvalid, Mysql2::Error => e
    #   log_query_error(e, sql)
    #   raise Errors::QueryError.new('Database query failed', sql, e)
    # rescue Timeout::Error => e
    #   log_timeout_error(sql)
    #   raise Errors::QueryError.new('Query timed out', sql, e)
    # rescue StandardError => e
    #   log_unexpected_error(e, sql)
    #   raise Errors::QueryError.new('Unexpected error', sql, e)
    # end
  end

  def structure_data # rubocop:disable Metrics/MethodLength
    @structured_data = { 'athlete_levels' => [] }

    unless @query.is_a?(ActiveRecord::Result)
      QUERY_LOGGER.error('Invalid query result type')
      return { error: 'Invalid data format' }
    end

    begin
      @query.each { |row| process_row(row) }
      log_structure_creation_success
      @structured_data
    rescue StandardError => e
      log_structure_error(e)
      { error: 'Data processing failed', details: e.message }
    end
  end

  def build_structure_query # rubocop:disable Metrics/MethodLength
    <<-SQL.squish
      SELECT
        athlete_levels.name AS athlete_level_name,
        kpi_categories.name AS kpi_category_name,
        steps.step_number,
        step_exercises.`order`,
        exercises.*
      FROM athlete_level_categories
      JOIN steps ON athlete_level_categories.id = steps.athlete_level_category_id
      JOIN step_exercises ON steps.id = step_exercises.step_id
      JOIN exercises ON step_exercises.exercise_id = exercises.id
      JOIN athlete_levels ON athlete_level_categories.athlete_level_id = athlete_levels.id
      JOIN kpi_categories ON athlete_level_categories.kpi_category_id = kpi_categories.id
      ORDER BY
        athlete_levels.name ASC,
        kpi_categories.name ASC,
        steps.step_number ASC,
        step_exercises.`order` ASC
    SQL
  end

  private # rubocop:disable Lint/UselessAccessModifier

  def verify_database_connection!
    return if ActiveRecord::Base.connected?

    Rails.logger.warn('Database connection lost - reconnecting...')
    ActiveRecord::Base.establish_connection
  end

  def with_query_timeout(seconds, &)
    Timeout.timeout(seconds, &)
  rescue Timeout::Error
    ActiveRecord::Base.connection.reconnect!
    raise
  end

  def validate_query_result(result)
    if result.blank?
      Rails.logger.warn('Query returned empty results')
      raise EmptyResultError, 'No data found'
    end

    required_columns = %w[athlete_level_name kpi_category_name step_number order]
    missing = required_columns - result.columns
    return if missing.empty?

    raise InvalidResultError, "Missing required columns: #{missing.join(', ')}"
  end

  def log_query_error(error, sql)
    Rails.logger.error(<<~ERROR)
      SQL Error: #{error.message}
      Query: #{sql}
      Error Class: #{error.class}
      #{error.backtrace.take(5).join("\n")}
    ERROR
  end

  def log_timeout_error(sql)
    Rails.logger.error(<<~ERROR)
      Query timed out after 10 seconds
      Partial SQL: #{sql.truncate(200)}
      Consider optimizing this query or increasing timeout
    ERROR
  end

  def log_unexpected_error(error, sql)
    Rails.logger.error(<<~ERROR)
      Unexpected Error: #{error.message}
      During query execution: #{sql.truncate(200)}
      Backtrace:
      #{error.backtrace.take(10).join("\n")}
    ERROR
  end

  def log_and_reconnect(error)
    Rails.logger.error("Database connection error: #{error.message} - Reconnecting...")
    ActiveRecord::Base.establish_connection
  end

  def process_row(row)
    athlete_level = find_or_create_athlete_level(row['athlete_level_name'])
    kpi_category = find_or_create_kpi_category(athlete_level, row['kpi_category_name'])
    step = find_or_create_step(kpi_category, row['step_number'])
    add_exercise_to_step(step, row)
  end

  def find_or_create_athlete_level(name)
    @structured_data['athlete_levels'].find { |al| al['meta']['display_name'] == name } ||
      create_new_athlete_level(name)
  end

  def create_new_athlete_level(name)
    new_level = {
      'meta' => {
        'type' => 'athlete_level',
        'display_name' => name,
        'key' => name.parameterize
      },
      'kpi_categories' => []
    }
    @structured_data['athlete_levels'] << new_level
    new_level
  end

  def find_or_create_kpi_category(athlete_level, name)
    athlete_level['kpi_categories'].find { |kc| kc['meta']['display_name'] == name } ||
      create_new_kpi_category(athlete_level, name)
  end

  def create_new_kpi_category(athlete_level, name)
    new_category = {
      'meta' => {
        'type' => 'kpi_category',
        'display_name' => name,
        'key' => name.parameterize
      },
      'steps' => []
    }
    athlete_level['kpi_categories'] << new_category
    new_category
  end

  def find_or_create_step(kpi_category, number)
    kpi_category['steps'].find { |s| s['meta']['number'] == number } ||
      create_new_step(kpi_category, number)
  end

  def create_new_step(kpi_category, number)
    new_step = {
      'meta' => {
        'type' => 'step',
        'number' => number,
        'key' => "step-#{number}"
      },
      'exercises' => []
    }
    kpi_category['steps'] << new_step
    new_step
  end

  def add_exercise_to_step(step, row)
    exercise_data = {
      'meta' => {
        'type' => 'exercise',
        'order' => row['order'],
        'key' => "ex-#{row['order']}-#{row['id']}"
      },
      'attributes' => row.except('athlete_level_name', 'kpi_category_name', 'step_number', 'order')
    }
    step['exercises'] << exercise_data
  end

  def log_structure_creation_success
    Rails.logger.info(
      'Successfully structured data: ' +
      "#{@structured_data['athlete_levels'].size} athlete levels, " +
      "#{@structured_data['athlete_levels'].sum { |al| al['kpi_categories'].size }} KPI categories"
    )
  end

  def log_structure_error(error)
    Rails.logger.error(
      "Failed to structure data: #{error.message}\n" +
      "Backtrace:\n#{error.backtrace.take(5).join("\n")}"
    )
  end
end
