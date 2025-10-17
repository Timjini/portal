# frozen_string_literal: true

module Api
  module V1
    class QuestionsController < Api::V1::BaseController
      def index
        questions = Question.order(:position)
        render json: questions, each_serializer: Api::V1::QuestionsSerializer, status: :ok
      end
    end
  end
end
