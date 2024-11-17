class Api::V2::TrainingPackagesController < Api::V1::BaseController
# skip authentication
 skip_before_action :authenticate_user!

  def index
    @training_packages = TrainingPackage.where(status: 'active')
    render json: @training_packages, status: :ok
  end
end