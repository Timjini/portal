# frozen_string_literal: true

module Api
  module V2
    class TrainingPackagesController < Api::V1::BaseController
      # skip authentication
      skip_before_action :authenticate_user!

      def index
        @training_packages = TrainingPackage.where(package_type: params[:package_type], status: 'active').limit(3)
        render json: { message: 'success', data: ActiveModelSerializers::SerializableResource.new(@training_packages, each_serializer: TrainingPackageSerializer) }
      end
    end
  end
end
