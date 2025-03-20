# frozen_string_literal: true

class AthleteProfilesController < ApplicationController
  before_action :authenticate_user!
  skip_forgery_protection only: %i[create checked_items]
  include NotificationHelper
  def index
    @users = User.where(role: %w[child_user athlete])
    if params[:level].present?
      @athletes = AthleteProfile.where(user_id: @users.ids).where(level: params[:level])
    else
      @users = User.where(role: %w[child_user athlete])
      @athletes = AthleteProfile.where(user_id: @users.ids)
    end
  end

  def show # rubocop:disable Metrics/MethodLength
    service = CheckListService.new(params)
    result = service.show_athlete_status
    @athlete = result[:athlete]
    @levels = result[:levels]
    Rails.logger.debug @levels.inspect.to_s
    @user = result[:user]
    @percentage = result[:percentage]
    @status = result[:status]
    @checklist_items_completed = result[:checklist_items_completed]
    @athlete_level = UserChecklist.where(completed: true, user_id: @athlete.user_id)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def new
    @athlete = AthleteProfile.new
  end

  def edit
    @athlete = AthleteProfile.find(params[:id])
  end

  def create # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    params[:athlete_profile][:level] = params[:level].to_i

    user = User.find_by(id: params[:athlete_profile][:user_id])
    existing_profile = AthleteProfile.find_by(user_id: params[:athlete_profile][:user_id])

    if existing_profile.present?
      existing_profile.update(athlete_params)
      flash[:warning] = 'Account has been updated!'
      redirect_to dashboard_path
    elsif user.present?
      @athlete = AthleteProfile.create(athlete_params)

      if @athlete.persisted?
        flash[:success] = 'Athlete Profile created!'
        redirect_to athlete_profile_path(@athlete)
      else
        flash[:warning] = 'Ooops something went wrong!'
        render 'new'
      end
    else
      flash[:warning] = 'User not found with the provided user_id!'
      redirect_to new_athlete_profile_path
    end
  end

  def athlete_users
    # users = User.where(role: ['athlete', 'parent_role', 'child_athlete'])
    user = User.find(params[:userId])
    render json: user
  end

  def autocomplete
    term = params[:term].downcase
    users = User.where(role: %w[athlete child_user])
                .where('LOWER(username) ILIKE ? OR LOWER(email) ILIKE ? OR LOWER(first_name) ILIKE ? OR LOWER(last_name) ILIKE ?', "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%") # rubocop:disable Layout/LineLength
                .pluck(:id, :username, :email, :first_name, :last_name)

    render json: users.map { |user|
      { id: user[0], username: user[1], first_name: user[2], last_name: user[3], email: user[4] }
    }
  end

  def edit_profile
    @athlete = AthleteProfile.find(params[:id])
  end

  def update
    params[:athlete][:level] = params[:level].to_i

    @athlete = AthleteProfile.find(params[:id])
    if @athlete.update(athlete_params)
      flash[:success] = 'AthleteProfile updated'
      redirect_to athlete_path(@athlete)
    else
      render :edit
    end
  end

  def checked_items
    service = CheckListService.new(params)
    result = service.update_checklist

    if result[:status] == 'error'
      render json: result
    else
      respond_to(&:turbo_stream)
    end
  end

  private

  def athlete_params
    params.require(:athlete_profile).permit(:first_name, :last_name, :dob, :height, :weight, :email, :phone,
                                            :school_name, :address, :city, :power_of_ten, :level, :image, :user_id)
  end
end
