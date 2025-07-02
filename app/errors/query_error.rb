# frozen_string_literal: true

module Errors
  class QueryError < StandardError
    attr_reader :sql

    def initialize(message, sql, original = nil)
      @sql = sql
      super("#{message}\nSQL: #{sql.truncate(200)}")
      set_backtrace(original.backtrace) if original
    end
  end

  class EmptyResultError < QueryError; end
  class InvalidResultError < QueryError; end
end
