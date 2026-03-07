# frozen_string_literal: true

module Api
  module V1
    class QuestionsController < Api::V1::BaseController
      def index
        questions = Question.order(:position)
        return render json: { error: 'Questions not loaded' }, status: :not_found if questions.blank?

        render json: questions, each_serializer: Api::V1::QuestionsSerializer, status: :ok
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end
    end
  end
end
