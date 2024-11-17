# frozen_string_literal: true

module Api
  module V2
    class TrainingPackageController < Api::V2::BaseController # rubocop:disable Style/Documentation
      skip_before_action :authenticate_user!

      def index
        @training_packages = TrainingPackage.where(status: 'active')
        render json: @training_packages, status: :ok
      end
    end
  end
end
