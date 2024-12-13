# frozen_string_literal: true

class ImportKpiDataJob < ApplicationJob
  queue_as :default

  def perform(file_path)
    CsvImportService.new(file_path).call do |row|
      process_kpi_data(row)
    end
  end

  private

  def process_kpi_data(row) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    level = row['level']
    step = row['step'].to_i
    title = row['title']
    degree = row['degree'].to_i
    category = row['category'].to_i

    service = KpiService.new(title: title, degree: degree, checklist: [], category: category, level: step)
    result = service.create_level

    if result[:success]
      Rails.logger.info "Level created successfully: #{result[:level].title}"
    else
      Rails.logger.error "Error creating level: #{result[:errors].join(', ')}"
    end
  end
end
