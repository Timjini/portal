# frozen_string_literal: true

class QuestionnairesController < ApplicationController
  def index
    @questionnaire = Questionnaire.last
    # @questions = Question.where(questionnaire_id: @questionnaire.id)
    @questions = Question.order(id: :asc).paginate(page: params[:page], per_page: 10)
  end

  def reports
    @reports = User.joins(:answers).includes(avatar_attachment: :blob).distinct.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
    @questions = Question.order(id: :asc)
    @answers = Answer.includes(:question).where(question_id: @questions.ids, user_id: params[:id])
  end
end
