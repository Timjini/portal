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
        @profile = @user.athlete_profile
    end

    def update_user
        puts "params: #{params}====================="

        @user = User.find(params[:id])
        
        @user.email = params[:user][:email]
        @user.username = params[:user][:username].downcase
        @user.first_name = params[:user][:first_name]
        @user.last_name = params[:user][:last_name]
        @user.role = params[:user][:role]
        @user.phone = params[:user][:phone]
        @user.address = params[:user][:address]
        @user.avatar = params[:user][:avatar]

        @user.save 

        @profile = @user.athlete_profile

        if @profile.nil?
            @profile = AthleteProfile.create(user_id: @user.id, level: 0, dob: params[:athlete_profile][:dob])
        end

        @profile.height = params[:athlete_profile][:height]
        @profile.weight = params[:athlete_profile][:weight]
        @profile.save 


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