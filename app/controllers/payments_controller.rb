# frozen_string_literal: true

require 'gocardless_pro'

class PaymentsController < ApplicationController
  def index
    @client = GoCardlessPro::Client.new(
      access_token: ENV.fetch('GOCARDLESS_TOKEN', nil),
      environment: :sandbox
    )

    @client.bank_authorisations.get('BAU123')

    puts @client.inspect
  end
end
