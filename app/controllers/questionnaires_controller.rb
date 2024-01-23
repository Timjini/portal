class QuestionnairesController < ApplicationController 

    def index
        @questionnaire = Questionnaire.last
        @questions = Question.where(questionnaire_id: @questionnaire.id)
    end

    def reports
        @reports = User.joins(:answers).distinct.paginate(page: params[:page], per_page: 5)
    end

    def show
        @user = User.find(params[:id])
        @questionnaire = User.find(params[:id])
        @questions = Question.where(questionnaire_id: 3)
        @answers = Answer.includes(:question).where(question_id: @questions.ids, user_id: params[:id])
    end


end