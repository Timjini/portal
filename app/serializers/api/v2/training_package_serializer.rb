# frozen_string_literal: true

module Api
  module V2
    class TrainingPackageSerializer < ActiveModel::Serializer
      attributes :id, :name, :description, :features, :price, :duration_in_days, :package_type, :training_type,
                 :duration, :status, :extra, :formatted_start_date, :formatted_end_date
      def formatted_start_date
        object.start_date.strftime('%a %d %B')
      end

      def formatted_end_date
        object.ending_date.strftime('%a %d %B')
      end
    end
  end
end
