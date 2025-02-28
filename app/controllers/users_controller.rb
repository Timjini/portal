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

  def edit_user
    @user = User.find(params[:id])
    @profile = @user.athlete_profile
  end

  def update_user
    @user = User.find(params[:id])

    if @user.update(user_params)
      @profile = @user.athlete_profile || AthleteProfile.new(user: @user)

      if @profile.update(athlete_profile_params)
        respond_to do |format|
          format.html { redirect_to @user, notice: 'User and profile were successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        end
      else
        respond_to do |format|
          format.html { render :edit }
          format.json { render json: @profile.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_user
    @user = User.find(params[:id])

    if @user.destroy
      flash[:notice] = 'User deleted successfully'
      render json: { success: true }
    else
      flash[:alert] = 'User not deleted'
      render json: { success: false }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :first_name, :last_name, :role, :phone, :address, :avatar)
  end

  def athlete_profile_params
    params.require(:athlete_profile).permit(:height, :weight, :dob, :level)
  end

  def search_users(query)
    User.where('name ILIKE ? OR username ILIKE ? OR email ILIKE ?', "%#{query}%", "%#{query}%", "%#{query}%")
  end
end
