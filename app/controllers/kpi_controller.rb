class KpiController < ApplicationController 

    before_action :authenticate_user!

    def index 
        @levels = Level.all
    end

    def create
        @kpi = Kpi.new(kpi_params)
        @kpi.save
        redirect_to kpi_index_path
    end


    private

    def kpi_params
        params.require(:kpi).permit(:name, :level_id, :value)
    end
end