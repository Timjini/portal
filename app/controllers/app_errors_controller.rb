# frozen_string_literal: true

class AppErrorsController < ApplicationController
  # before_action :authenticate_user!
  # before_action :authenticate_user!
  # load_and_authorize_resource

  def index
    @errors = AppError.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def show
    @error = AppError.find(params[:id])
  end

  def destroy
    @error = AppError.find(params[:id])
    if @error.destroy
      flash[:notice] = 'Error log deleted successfully.' # rubocop:disable Rails/I18nLocaleTexts
      redirect_to app_errors_path
    else
      flash[:alert] = 'Failed to delete error log.' # rubocop:disable Rails/I18nLocaleTexts
      render :show
    end
  end
end
