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
    @subscription = service.get_subscription
  end

  def subscription
  end

  def requests
    service = BillingService.new(200, 'new product', current_user)
    billing = service.list_billing_requests # This is the ListResponse object

    # Use .records to get the array of objects
    @billing_requests = billing.records
  end

  def landing
    puts params.inspect
    # The ID comes back in the params
    # brq_id = params[:billing_request_id]

    # You can now verify if it's successful
    # result = @client.billing_requests.get(brq_id)

    # if result.status == 'fulfilled'
    #   flash[:notice] = 'Thank you! Your bank is now linked.'
    # else
    #   flash[:alert] = 'Something went wrong.'
    # end

    # redirect_to dashboard_path
  end

  def exit
  end
end
