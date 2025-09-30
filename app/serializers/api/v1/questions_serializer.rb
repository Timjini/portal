# frozen_string_literal: true

module Api
    module V1
      class QuestionsSerializer < ActiveModel::Serializer
        attributes :id, :content, :question_type, :questionnaire_id, :options, :position, :illness_tag, :parsed_options, :created_at, :updated_at

        def parsed_options
            object.options.is_a?(String) ? JSON.parse(object.options) : object.options
        end
      end
    end
end
  