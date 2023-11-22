class KpiController < ApplicationController 

    before_action :authenticate_user!

    def index 
        @levels = Level.all
    end
end