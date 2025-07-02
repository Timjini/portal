# frozen_string_literal: true

class ExerciseStructureQuery
  def initialize
    @structured_data = {}
  end

  def call
    execute_query
    structure_data
    @structured_data
  end

  private

  def execute_query
    @query = ActiveRecord::Base.connection.execute(
      ActiveRecord::Base.sanitize_sql([<<-SQL.squish])
        SELECT
          athlete_levels.name AS athlete_level_name,
          kpi_categories.name AS kpi_category_name,
          steps.step_number,
          step_exercises.order AS exercise_order,
          exercises.*
        FROM athlete_level_categories
        JOIN steps ON athlete_level_categories.id = steps.athlete_level_category_id
        JOIN step_exercises ON steps.id = step_exercises.step_id
        JOIN exercises ON step_exercises.exercise_id = exercises.id
        JOIN athlete_levels ON athlete_level_categories.athlete_level_id = athlete_levels.id
        JOIN kpi_categories ON athlete_level_categories.kpi_category_id = kpi_categories.id
        ORDER BY step_exercises.order
      SQL
    )
  end

  def structure_data # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength
    # Start with an array (will become array of athlete levels)
    @structured_data = {
      'athlete_levels' => []
    }

    @query.each do |row| # rubocop:disable Metrics/BlockLength
      athlete_level_name = row['athlete_level_name']
      kpi_category_name = row['kpi_category_name']
      step_number = row['step_number']
      exercise_order = row['order']

      # Find or create athlete level
      athlete_level = @structured_data['athlete_levels'].find do |al|
        al['meta']['display_name'] == athlete_level_name
      end || begin
        new_level = {
          'meta' => {
            'type' => 'athlete_level',
            'display_name' => athlete_level_name,
            'key' => athlete_level_name.parameterize # Creates URL-friendly key
          },
          'kpi_categories' => []
        }
        @structured_data['athlete_levels'] << new_level
        new_level
      end

      # Find or create KPI category
      kpi_category = athlete_level['kpi_categories'].find do |kc|
        kc['meta']['display_name'] == kpi_category_name
      end || begin
        new_category = {
          'meta' => {
            'type' => 'kpi_category',
            'display_name' => kpi_category_name,
            'key' => kpi_category_name.parameterize
          },
          'steps' => []
        }
        athlete_level['kpi_categories'] << new_category
        new_category
      end

      # Find or create step
      step = kpi_category['steps'].find { |s| s['meta']['number'] == step_number } || begin
        new_step = {
          'meta' => {
            'type' => 'step',
            'number' => step_number,
            'key' => "step-#{step_number}"
          },
          'exercises' => []
        }
        kpi_category['steps'] << new_step
        new_step
      end

      # Add exercise
      step['exercises'] << {
        'meta' => {
          'type' => 'exercise',
          'order' => exercise_order,
          'key' => "ex-#{exercise_order}-#{row['id']}"
        },
        'attributes' => row.except('athlete_level_name', 'kpi_category_name', 'step_number', 'order')
      }
    end

    @structured_data
  end
end
