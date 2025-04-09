# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  def has_health_issue # rubocop:disable Naming/PredicateName
    answers = Answer.where(user_id: user_id)
    answers.any? { |answer| answer.content == 'Yes' } ? 'Yes' : 'No'
  end
end
