class QuestionnairesController < ApplicationController 

    def index
        @questionnaire = Questionnaire.last

        @questions = Question.where(questionnaire_id: @questionnaire.id)
    end

end