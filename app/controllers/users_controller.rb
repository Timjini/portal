class UsersController < ApplicationController

    def index
        @levels = Level.all
    end

    def show

        #Levels 
        @levels = Level.all

        @user = User.find(params[:id])
        respond_to do |format|
            format.html { render :show }
            format.json { render json: @user }
        end
    end

end