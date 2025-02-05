class OnboardingController < ApplicationController

  def index
    @new_session = session[:onboarding]
  end
end