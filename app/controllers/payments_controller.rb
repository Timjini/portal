# frozen_string_literal: true

require 'gocardless_pro'

class PaymentsController < ApplicationController
  # def index
  #   service = BillingService.new(200, 'new product', current_user)
  #   auth_url = service.create_billing

  #   redirect_to auth_url, allow_other_host: true
  # end

  def index
    service = BillingService.new(current_user)

    auth_url = service.create_billing

    redirect_to auth_url, allow_other_host: true
  end

  def subscription; end

  def requests
    service = BillingService.new(current_user)
    billing = service.list_billing_requests

    # Use .records to get the array of objects
    @billing_requests = billing.records
  end

  def landing
    service = BillingService.new(current_user)
    service.create_subscription
  rescue StandardError => e
    Rails.logger.info("issue with subscription #{e.message}")
  end

  def exit; end
end
