# frozen_string_literal: true

class AccountsController < ApplicationController
  skip_forgery_protection only: [:new]
  before_action :authenticate_user!
  # include AthleteProfilesHelper

  # load_and_authorize_resource

  def index
    accounts_scope = if current_user.role == 'parent_user'
                       User.where(parent_id: current_user.id)
                     else
                       User.all
                     end

    accounts_scope = accounts_scope.includes(:athlete_profile, :coach_calendars, avatar_attachment: :blob)

    @accounts = accounts_scope.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @child = current_user.children.build
    @child.build_athlete_profile
  end

  def create
    @child = current_user.children.build(account_params)
    if @child.save
      redirect_to dashboard_path, notice: 'Athlete profile created!' # rubocop:disable Rails/I18nLocaleTexts
    else
      flash.now[:alert] = 'Please fix the errors below.' # rubocop:disable Rails/I18nLocaleTexts
      render :new, status: :unprocessable_content
    end
  end

  def all_accounts # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    base_scope = User.includes(:athlete_profile, :plan, avatar_attachment: :blob)
    base_scope = base_scope.where(role: params[:role]) if params[:role].present?
    # base_scope = base_scope.with_coach_calendars if params[:role].nil? || params[:role] == 'coach'
    @plans = Plan.pluck(:id, :name)
    @accounts = if params[:search].present?
                  search_accounts(params)
                else
                  base_scope.paginate(page: params[:page], per_page: 10)
                end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def search_accounts(params) # rubocop:disable Metrics/MethodLength
    search_term = params[:search].to_s.strip.downcase
    Rails.logger.info "Searching accounts with params: #{search_term.inspect}"

    if search_term.blank?
      @accounts = User.includes(:athlete_profile, :avatar_attachment)
                      .paginate(page: params[:page], per_page: 10)
    else
      term = "%#{search_term}%"
      @accounts = User.includes(:athlete_profile, :avatar_attachment)
                      .where('LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ? OR LOWER(email) LIKE ?',
                             term, term, term)
                      .paginate(page: params[:page], per_page: 10)
    end

    @accounts
  end

  def add_child; end

  private

  def account_params
    params.require(:user).permit(
      :username, :email, :first_name, :last_name, :password, :password_confirmation, :role, :parent_id, :avatar,
      athlete_profile_attributes: %i[id dob school_name height weight]
    )
  end
end
