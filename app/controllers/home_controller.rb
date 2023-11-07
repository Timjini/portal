class HomeController < ApplicationController

    def index 
    end

    def subscriptions
        @subscriptions = User.where.not(role: ['coach', 'admin', 'child_user'])
    end

end