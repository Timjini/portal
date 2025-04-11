# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_parent, only: %i[index create create_child_user add_child]
  skip_forgery_protection only: [:create_child_user]

  include AthleteProfilesHelper

  # GET /accounts
  def index
    @accounts = current_user.child_users.includes(:athlete_profile)
    respond_to do |format|
      format.html
      format.json { render json: @accounts, include: :athlete_profile }
    end
  end

  # GET /accounts/all
  def all_accounts
    @accounts = User.includes(:athlete_profile)
                    .by_role(params[:role])
                    .paginate(page: params[:page], per_page: 10)
  end

  # POST /accounts
  def create
    @account = current_user.child_users.new(account_params.merge(
                                              email: current_user.email,
                                              role: 'child_user'
                                            ))

    if @account.save
      redirect_to accounts_path, notice: 'Child account created successfully.' # rubocop:disable Rails/I18nLocaleTexts
    else
      render :add_child, status: :unprocessable_entity
    end
  end

  # POST /accounts/create_child_user
  def create_child_user # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    @account = current_user.child_users.new(child_user_params)
    @account.avatar.attach(params[:avatar]) if params[:avatar].present?

    if @account.save
      create_athlete_profile_for_child(@account)
      render json: { status: 'success', message: 'Child user created!' }, status: :created
    else
      render json: {
        status: 'error',
        message: 'Oops, something went wrong!',
        errors: @account.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # GET /accounts/add_child
  def add_child
    @account = current_user.child_users.new
  end

  private

  def child_user_params # rubocop:disable Metrics/MethodLength
    params.permit(
      :first_name,
      :last_name,
      :username,
      :password,
      :dob,
      :school_name,
      :height,
      :weight
    ).tap do |whitelisted|
      whitelisted[:email] = current_user.email
      whitelisted[:role] = 'child_user'
      whitelisted[:address] = current_user.address
      whitelisted[:username] = whitelisted[:username]&.downcase
    end
  end

  def account_params
    params.require(:user).permit(:username, :password)
  end

  def authorize_parent
    return if current_user.parent_user?

    redirect_to root_path, alert: 'You are not authorized to perform this action.' # rubocop:disable Rails/I18nLocaleTexts
  end

  def create_athlete_profile_for_child(child_user)
    create_athlete_child_profile(
      child_user.id,
      params[:dob],
      params[:school_name],
      params[:password],
      params[:height],
      params[:weight]
    )
  end
end
