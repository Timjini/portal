# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:public_page]

  def index; end

  def public_page; end

  # def subscriptions
  #     @subscriptions = User.where.not(role: ['coach', 'admin', 'child_user'])
  # end

  # def send_email_test
  #     UserMailer.test_email.deliver_now
  #     redirect_to root_path
  # end
end
