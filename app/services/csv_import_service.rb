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
      row_hash = row.to_h
      if block_given?
        yield row_hash
      else
        process_row(row_hash)
      end
    end
  end

  private

  def process_row(_row)
    raise NotImplementedError, 'You must override `process_row` or provide a block when calling the service'
  end
end
