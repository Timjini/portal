# frozen_string_literal: true

module Juniors
  class DashboardController < ApplicationController
    before_action :authenticate_user!

    def index
      # @children = current_user.children
    end

    private

    def authenticate_user!
      redirect_to new_user_session_path unless user_signed_in?
    end
  end
end
