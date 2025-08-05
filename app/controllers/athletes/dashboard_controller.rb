# frozen_string_literal: true

module Athletes
  class DashboardController < ApplicationController
    # before_action :authenticate_user!

    def index
      # @athlete = current_user.athlete
      # @training_plans = @athlete.training_plans
      # @goals = @athlete.goals
      # @feedbacks = @athlete.feedbacks
    end

    private

    # def authenticate_user!
    #   redirect_to new_user_session_path unless user_signed_in?
    # end
  end
end
