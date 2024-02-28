class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question


  def has_health_issue
    answers = Answer.where(user_id: self.user_id)
    answers.any? { |answer| answer.content == "Yes" } ? "Yes" : "No"
  end





end
