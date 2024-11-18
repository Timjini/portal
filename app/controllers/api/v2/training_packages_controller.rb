# frozen_string_literal: true

module Api
  module V2
    class TrainingPackagesController < Api::V1::BaseController
      # skip authentication
      skip_before_action :authenticate_user!

      def index
        @training_packages = TrainingPackage.where(status: 'active').limit(3)
        render json: @training_packages, status: :ok
      end
    end
  end
end
