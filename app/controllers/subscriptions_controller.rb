# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  def index
    Rails.logger.info("params ss ---------------> #{params.inspect}")
    @subscription_plans = Plan.all
  end
end
