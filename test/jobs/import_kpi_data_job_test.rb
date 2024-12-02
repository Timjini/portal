# frozen_string_literal: true

require 'test_helper'
require 'minitest/mock'
require 'ostruct'

class ImportKpiDataJobTest < ActiveJob::TestCase
  setup do
    @csv_file_path = Rails.root.join('test/fixtures/files/test.csv')
    @kpi_service_mock = Minitest::Mock.new
  end

  test 'processes CSV file and creates KPI levels' do
    # Stubbing KpiService.new to return the mock object
    KpiService.stub :new, @kpi_service_mock do
      # Expecting the `create_level` method to be called with a Hash argument
      row_hash = { 'level' => '1', 'step' => '1', 'title' => 'Sample Title', 'degree' => '1', 'category' => '1' }
      
      # Expect create_level to be called with a hash as argument
      @kpi_service_mock.expect :create_level, { success: true, level: OpenStruct.new(title: 'Sample Title') }, [Hash]

      # Perform the job with the CSV file path
      ImportKpiDataJob.perform_now(@csv_file_path)

      # Verifying that the mock method was called with the correct argument (the hash)
      @kpi_service_mock.verify
    end
  end

  test 'logs errors if level creation fails' do
    # Stub the KpiService#create_level method to return a failure response
    KpiService.stub :new, @kpi_service_mock do
      @kpi_service_mock.expect :create_level, { success: false, errors: ['Sample Error'] }, [Hash]

      # Perform the job
      ImportKpiDataJob.perform_now(@csv_file_path)

      # Verify the expectations
      @kpi_service_mock.verify
    end
  end
end
