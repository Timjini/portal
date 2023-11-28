class AccountsController < ApplicationController
    skip_forgery_protection only: [:create_child_user]
    before_action :authenticate_user! 
    include AthleteProfilesHelper

    def index
        if current_user.role == 'parent_user'
            @accounts = User.where(parent_id: current_user.id).includes(:athlete_profile)
        else
            @accounts = nil
        end
    end

    def show
        @accounts = User.all
    end

    def create
        @account = User.new(account_params)
        @account.email = current_user.email
        @account.parent_id = current_user.id
        @account.role = 'child_user'
        @account.save
        redirect_to accounts_path
    end

    def create_child_user
        @account = User.new
        @account.email = current_user.email
        @account.parent_id = current_user.id
        @account.first_name = params[:first_name]
        @account.last_name = params[:last_name]
        @account.username = params[:username].downcase
        @account.password = params[:password]
        @account.address = current_user.address
        @account.role = 'child_user'
        
        if @account.save
            create_athlete_child_profile(@account.id, params[:dob], params[:school_name], params[:password])
            flash[:success] = "Child user created!"

            respond_to do |format|
                #format.html { redirect_to accounts_path }
                format.json { render json: { status: 'success', message: 'Child user created!' } }
            end
            else
            flash[:alert] = "Oops, something went wrong!"

            respond_to do |format|
                format.html { render 'new' }
                format.json { render json: { status: 'error', message: 'Oops, something went wrong!' } }
            end
        end
    end

    def all_accounts
        @accounts = User.all
    end

    private

    def account_params
        params.require(:user).permit(:email,:username, :password, :role)
    end
end