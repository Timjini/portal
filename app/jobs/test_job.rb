# frozen_string_literal: true

class TestJob < ApplicationJob
  def perform
    Rails.logger.debug "-==========>Hello from the TestJob!" # rubocop:disable Style/StringLiterals
  end
end
