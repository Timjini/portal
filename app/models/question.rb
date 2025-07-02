# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :questionnaire
  has_many :answers, dependent: :destroy

  enum :question_type, {
    radio: 'radio',
    multiple: 'multiple',
    text: 'text'
  }

  def parsed_options
    parsed = options.is_a?(String) ? JSON.parse(options) : options
    parsed.is_a?(Array) ? parsed : []
  rescue JSON::ParserError
    []
  end
end
