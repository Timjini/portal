# frozen_string_literal: true

class AnswersController < ApplicationController
  skip_forgery_protection only: [:create]

  def create
    params[:answers].each do |answer_params|
      answer = Answer.new
      answer.user_id = params[:user_id]
      answer.question_id = answer_params[:question_id]
      answer.content = answer_params[:content]
      answer.save!
    end
    render json: { status: 'success', message: 'Answers created successfully' }
  rescue StandardError => e
    render json: { status: 'error', message: e.message }, status: :unprocessable_content
  end

  # private

  # # def answers_params
  # #   params.require(:answers).permit(:question_id, :content, :user_id)
  # # end
end
