# frozen_string_literal: true

class AccountsController < ApplicationController
  skip_forgery_protection only: [:create_child_user]
  before_action :authenticate_user!
  include AthleteProfilesHelper
  # load_and_authorize_resource

  def index
    @accounts = if current_user.role == 'parent_user'
                  User.where(parent_id: current_user.id)
                      .includes(:athlete_profile, avatar_attachment: :blob)
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

  def create_child_user # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    @account = User.new
    @account.email = current_user.email
    @account.parent_id = current_user.id
    @account.first_name = params[:first_name]
    @account.last_name = params[:last_name]
    @account.username = params[:username].downcase
    @account.password = params[:password]
    @account.avatar = params[:avatar]
    @account.address = current_user.address
    @account.role = 'child_user'

    if @account.save
      create_athlete_child_profile(@account.id, params[:dob], params[:school_name], params[:password],
                                   params[:height], params[:weight])
      flash[:success] = 'Child user created!' # rubocop:disable Rails/I18nLocaleTexts

      respond_to do |format|
        # format.html { redirect_to accounts_path }
        format.json { render json: { status: 'success', message: 'Child user created!' } }
      end
    else
      flash[:alert] = 'Oops, something went wrong!' # rubocop:disable Rails/I18nLocaleTexts

      respond_to do |format|
        format.html { render 'new' }
        format.json { render json: { status: 'error', message: 'Oops, something went wrong!' } }
      end
    end
  end

  def all_accounts
    @accounts = if params[:role].present?
                  User.includes([:athlete_profile]).where(role: params[:role]).paginate(page: params[:page],
                                                                                        per_page: 10).includes([:avatar_attachment])
                else
                  User.includes([:athlete_profile]).all.paginate(page: params[:page],
                                                                 per_page: 10).includes(%i[
                                                                                          coach_calendars avatar_attachment
                                                                                        ])
                end
  end

  def add_child; end

  private

  def account_params
    params.require(:user).permit(:email, :username, :password, :role)
  end
end
