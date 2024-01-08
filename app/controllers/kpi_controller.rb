class KpiController < ApplicationController
    skip_forgery_protection only: [:create, :destroy , :update]

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
            respond_to do |format|
                # format.html { redirect_to kpis_path }
                format.json { render json: { status: 'success', message: 'Level created!' } }
            end
            
        else           
            respond_to do |format|
                format.html { render 'new' }
                format.json { render json: { status: 'error', message: 'Oops, something went wrong!' } }
            end

        end
    end

    def edit
        @level = Level.find(params[:id])
        @check_list = CheckList.where(level_id: @level.id)
    end


    def update
        checklist_data_json = params[:checklist_data]
        checklist_data = JSON.parse(checklist_data_json)
        puts "Checklist data: #{checklist_data.inspect}"

        checklist_data.each do |item|
            checklist_item = CheckList.find(item['id'])
            checklist_item.update(title: item['title'])
        end

        @level = Level.find(params[:id])
        @level.title = params[:title]
        @level.degree = params[:degree].to_i
        @level.category = params[:category].to_i

        @level.save!

        if @level.save
            respond_to do |format|
                # format.html { redirect_to kpis_path }
                format.json { render json: { status: 'success', message: 'Level created!' , redirect_url: '/kpis'  } }
            end
        else
            render json: { success: false }
        end

        # @level = Level.find(params[:id])

        # if @level.update(level_params)
        #     redirect_to @level, notice: 'Level was successfully updated.'
        # else
        #     render :edit
        # end
    end

    def destroy
        @level = Level.find(params[:id])
        # destroy level
        if @level.destroy
            render json: { success: true }
        else
            render json: { success: false }
        end
    end




    private


end