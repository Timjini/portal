# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:delete_user]
  skip_before_action :verify_authenticity_token, only: [:delete_user]

  def index
    @levels = Level.all
    @users = if params[:query].present?
               User.search_by_name_username_email(params[:query])
             else
               User.all
             end
  end

  def show
    # Levels
    @levels = Level.all

    @user = User.find(params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @user }
    end
  end

  def delete_user
    @user = User.find(params[:id])

    if @user.destroy
      flash[:notice] = 'User deleted successfully' # rubocop:disable Rails/I18nLocaleTexts
      render json: { success: true }
    else
      flash[:alert] = 'User not deleted' # rubocop:disable Rails/I18nLocaleTexts
      render json: { success: false }
    end
  end

  def edit
    @user = User.find(params[:id])
    @profile = @user.athlete_profile || @user.build_athlete_profile
  end

  def update_user # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    @user = User.find(params[:id])
    @profile = @user.athlete_profile || @user.build_athlete_profile
    if @user.update(user_params) && @profile.update(athlete_profile_params)
      redirect_to users_path(@user), notice: 'Profile updated successfully'
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      redirect_to edit_user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email, :username, :first_name, :last_name,
      :phone, :address, :avatar, :role
    )
  end

  def athlete_profile_params
    return {} if params[:user][:athlete_profile].blank?

    params.require(:user).require(:athlete_profile).permit(
      :id, :first_name, :last_name, :dob, :height,
      :weight, :school_name, :level, :power_of_ten
    )
  end

  def search_users(query)
    User.where('name ILIKE ? OR username ILIKE ? OR email ILIKE ?', "%#{query}%", "%#{query}%", "%#{query}%")
  end
end
