class AccountsController < ApplicationController
    before_action :authenticate_user! 

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

    def all_accounts
        @accounts = User.all
    end

    private

    def account_params
        params.require(:user).permit(:email,:username, :password, :role)
    end
end