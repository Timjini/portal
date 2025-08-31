# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  def health_issue?
    Answer.joins(:question)
    .where(user_id: user_id, content: 'Yes')
    .where.not(questions: { illness_tag: nil })
    .distinct
    .pluck('questions.illness_tag')
  end

  def health_issue(user_id)
    self.joins(:question)
    .where(user_id: user_id, content: 'Yes')
    .where.not(questions: { illness_tag: nil })
    .distinct
    .pluck('questions.illness_tag')
  end
end
