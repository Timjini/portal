class UsersController < ApplicationController

    def index
    end

    def show
        @user = User.find(params[:id])
        respond_to do |format|
            format.html { render :show }
            format.json { render json: @user }
        end
    end

end