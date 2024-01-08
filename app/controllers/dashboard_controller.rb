class DashboardController < ApplicationController
before_action :authenticate_user!

    def index
        # Parent Account 
        @children = User.where(parent_id: current_user.id)

        # Child Account

        # Athlete Account

        # Coach Account
    end

    def goals_rewards_acheivements
    end


end