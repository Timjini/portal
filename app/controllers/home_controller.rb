class HomeController < ApplicationController

    skip_forgery_protection only: [:send_email_test]

    def index 
    end

    def subscriptions
        @subscriptions = User.where.not(role: ['coach', 'admin', 'child_user'])
    end

    def send_email_test
        UserMailer.test_email.deliver_now
        redirect_to root_path
    end

end