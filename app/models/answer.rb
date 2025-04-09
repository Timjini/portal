# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  def health_issue?
    answers = Answer.where(user_id: user_id)
    answers.any? { |answer| answer.content == 'Yes' } ? 'Yes' : 'No'
  end
end
