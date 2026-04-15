# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  def index
    @subscription_plans = Plan.all
  end
end
