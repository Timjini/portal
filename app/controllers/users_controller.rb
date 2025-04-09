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

  # TODO: before release
  def update_user
    @user = User.find(params[:id])
    @profile = @user.athlete_profile || AthleteProfile.new(user: @user)
    begin
      p athlete_profile_params
      @profile.update(params[:height])
    rescue StandardError => e
      put "error here, #{e}"
    end

    # respond_to do |format|
    #   if @user.update(user_params)
    #     format.turbo_stream do
    #       render turbo_stream: [
    #         turbo_stream.replace('flash', partial: 'shared/flash', locals: { notice: 'Profile updated successfully' }),
    #         turbo_stream.replace(@user, partial: 'users/form', locals: { user: @user })
    #       ]
    #     end
    #     format.html { redirect_to @user, notice: 'User and profile were successfully updated.' }
    #   else
    #     format.turbo_stream do
    #       render turbo_stream: turbo_stream.replace('flash', partial: 'shared/flash',
    #                                                          locals: { alert: 'Error updating profile' })
    #     end
    #     format.html { render :edit }
    #   end
    # end
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

  private

  def search_users(query)
    User.where('name ILIKE ? OR username ILIKE ? OR email ILIKE ?', "%#{query}%", "%#{query}%", "%#{query}%")
  end

  def user_params # rubocop:disable Metrics/MethodLength
    params.require(:user).permit(:email,
                                 :username,
                                 :first_name,
                                 :last_name,
                                 :role,
                                 :phone,
                                 :address,
                                 :avatar,
                                 :dob,
                                 :school_name,
                                 athlete_profile_attributes: %i[id height weight level])
  end

  def athlete_profile_params
    params.require(:athlete_profile).permit(:height, :weight, :dob, :level)
  end
end
