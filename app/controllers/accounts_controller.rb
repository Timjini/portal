class AccountsController < ApplicationController
    before_action :authenticate_user!

    def index
        if current_user.role == 'athlete_parent'
            @accounts = User.where(parent_id: current_user.id).includes(:athlete_profile)
        else
            @accounts = current_user
        end
    end

    def create
        @account = User.new(account_params)
        @account.email = current_user.email
        @account.parent_id = current_user.id
        @account.role = 'child_athlete'
        @account.save
        redirect_to accounts_path
    end


    private

    def account_params
        params.require(:user).permit(:email,:username, :password, :role)
    end
end