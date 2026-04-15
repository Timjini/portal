# frozen_string_literal: true

require 'gocardless_pro'

class PaymentsController < ApplicationController
  # def index
  #   service = BillingService.new(200, 'new product', current_user)
  #   auth_url = service.create_billing

  #   redirect_to auth_url, allow_other_host: true
  # end

  def index
    @payment_information = {}
    if current_user.role == 'parent_user'
      @payment_information[:payments] = current_user.children.includes(%i[payments]).flat_map(&:payments)
      @payment_information[:current_plan] = current_user.children
    else
      @payment_information[:payments] = current_user.payments
      @payment_information[:current_plan] = current_user
    end
  end

  def create
    user = User.find(params[:athlete])
    plan= UserPlan.find_or_create_by(user_id: user.id)
    # UserPlan.create!(user_id: user.id, plan_id: params[:plan_id]) unless user.plan

    service = BillingService.new(user)
    auth_url = service.create_billing

    return flash[:alert] = 'Must have a subscription' unless auth_url # rubocop:disable Rails/I18nLocaleTexts

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
