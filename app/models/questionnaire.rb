# frozen_string_literal: true

class Questionnaire < ApplicationRecord
  has_many :questions # rubocop:disable Rails/HasManyOrHasOneDependent

  def parsed_options
    options.is_a?(String) ? JSON.parse(options) : options
  end
end
