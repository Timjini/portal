# frozen_string_literal: true

class AccountsController < ApplicationController
  skip_forgery_protection only: [:create_child_user]
  before_action :authenticate_user!
  include AthleteProfilesHelper

  # load_and_authorize_resource

  def index
    @accounts = if current_user.role == 'parent_user'
                  User.where(parent_id: current_user.id)
                      .includes(:athlete_profile, :coach_calendars, avatar_attachment: :blob)
                      .paginate(page: params[:page], per_page: 10)
                end
  end

  def show
    @account = User.includes([:athlete_profile])
  end

  def create
    @account = User.new(account_params)
    @account.email = current_user.email
    @account.parent_id = current_user.id
    @account.role = 'child_user'
    @account.save
    redirect_to accounts_path
  end

  # this shouldn't be here :(
  def create_child_user # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    safe_action(:create_child_user) do # rubocop:disable Metrics/BlockLength
      @account = User.new(
        email: current_user.email,
        parent_id: current_user.id,
        first_name: params[:first_name],
        last_name: params[:last_name],
        username: params[:username].downcase,
        password: params[:password],
        avatar: params[:avatar],
        address: current_user.address,
        role: 'child_user'
      )

      if @account.save
        create_athlete_child_profile(
          @account.id,
          params[:dob],
          params[:school_name],
          params[:password],
          params[:height],
          params[:weight]
        )

        respond_to do |format|
          format.html { redirect_to root_path, notice: 'Child created successfully' } # rubocop:disable Rails/I18nLocaleTexts
          format.json { render json: { status: 'success' } }
        end
      else
        respond_to do |format|
          format.html do
            flash.now[:alert] = @account.errors.full_messages.to_sentence || 'Failed to create child user.'
            redirect_to add_child_accounts_path, alert: 'Failed to create child user.' # rubocop:disable Rails/I18nLocaleTexts
          end
          format.json do
            render json: {
              status: 'error',
              errors: @account.errors.full_messages
            }, status: :unprocessable_entity
          end
        end
      end
    end
  end

  def all_accounts # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    Rails.logger.info "Fetching accounts with params: #{params.inspect}"

    base_scope = User.includes(:athlete_profile, avatar_attachment: :blob)
    base_scope = base_scope.where(role: params[:role]) if params[:role].present?
    base_scope = base_scope.with_coach_calendars if params[:role].nil? || params[:role] == 'coach'

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

  def search_accounts(params)
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
    params.require(:user).permit(:email, :username, :password, :role)
  end
end
