# frozen_string_literal: true

require 'csv'

class CsvImportService
  def initialize(file_path, headers: true)
    @file_path = file_path
    @headers = headers
  end

  def call
    raise 'File does not exist' unless File.exist?(@file_path)

    CSV.foreach(@file_path, headers: @headers) do |row|
      if block_given?
        yield row
      else
        process_row(row)
      end
    end
  end

  private

  def process_row(row)
    process_rows(row)
  rescue NotImplementedError
    raise NotImplementedError, 'You must override `process_row` or provide a block when calling the service'
  end

  def process_rows(row)
    # Default implementation raises an error if not overridden
    raise NotImplementedError, 'You must implement the `process_rows` method in the subclass or pass a block'
  end
end
