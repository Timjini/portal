class UsersController < ApplicationController
    before_action :authenticate_user! , except: [:delete_user]
    skip_before_action :verify_authenticity_token, only: [:delete_user]


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

    def edit_user
        @user = User.find(params[:id])
       
    end

    def update_user
        @user = User.find(params[:id])
        @user.update(user_params)
        respond_to do |format|
            format.html { render :show }
            format.json { render json: @user }
        end
    end

    def delete_user
    @user = User.find(params[:id])

        if @user.destroy
            flash[:notice] = "User deleted successfully"
            render json: { success: true }
        else
            flash[:alert] = "User not deleted"
            render json: { success: false }
        end
    end

end