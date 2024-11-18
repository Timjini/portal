# frozen_string_literal: true

# app/controllers/answers_controller.rb
class AnswersController < ApplicationController
  skip_forgery_protection only: [:create]

  def create
    answers_params[:answers].each do |answer_params|
      answer = Answer.new
      answer.user_id = answer_params[:user_id]
      answer.question_id = answer_params[:question_id]
      answer.content = answer_params[:content]
      answer.save!
    end

    render json: { status: 'success', message: 'Answers created successfully', url: '/' }
  rescue StandardError => e
    render json: { status: 'error', message: e.message }, status: :unprocessable_entity
  end

  private

  def answers_params
    params.permit(answers: %i[question_id content user_id])
  end
end
