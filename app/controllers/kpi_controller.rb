class KpiController < ApplicationController 
    skip_forgery_protection only: [:create, :destroy]

    before_action :authenticate_user!

    def index 
        @levels = Level.all
    end

    def create
        puts "params: #{params.inspect}"

        title = params[:title]
        degree = params[:degree].to_i
        checklist_items = params[:checklist]

        @level = Level.new(title: title , degree: degree)
       
        if @level.save

            checklist_items.each do |item|
                CheckList.create!(title: item, level_id: @level.id)
            end

            flash[:success] = "Level created!"

            respond_to do |format|
                # format.html { redirect_to kpis_path }
                format.json { render json: { status: 'success', message: 'Level created!' } }
            end
            
        else
            flash[:alert] = "Oops, something went wrong!"
           
            respond_to do |format|
                format.html { render 'new' }
                format.json { render json: { status: 'error', message: 'Oops, something went wrong!' } }
            end

        end
    end

    def destroy
        @level = Level.find(params[:id])
        # destroy level
        if @level.destroy
            flash[:success] = "Level deleted!"
            redirect_to kpis_path
        else
            flash[:alert] = "Oops, something went wrong!"
            redirect_to kpis_path
        end
    end




    private

    def level_params
        params.require(:kpi).permit(:title, :degree, :category)
    end
end