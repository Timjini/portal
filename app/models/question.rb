# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :questionnaire
  has_many :answers, dependent: :destroy

  enum :question_type, {
    radio: 'radio',
    multiple: 'multiple',
    text: 'text'
  }
end
