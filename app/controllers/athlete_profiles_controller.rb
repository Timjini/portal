class AthleteProfilesController < ApplicationController
  before_action :authenticate_user!

  include AthleteProfilesHelper

    def index
      if params[:level].present?
        @athletes = AthleteProfile.where(level: params[:level])
      else
        @athletes = AthleteProfile.all
      end
    end

    def show
        @athlete = AthleteProfile.find(params[:id])
    end

    def edit
    @athlete = AthleteProfile.find(params[:id])
    end

    def new
      @athlete = AthleteProfile.new
    end

    def create
        params[:athlete_profile][:level] = params[:level].to_i

        user = User.find_by(email:params[:athlete_profile][:email])


      if user.present?
        @athlete = AthleteProfile.create!(athlete_params)
      else
        user_account = User.new(
          email:params[:athlete_profile][:email],
          username:params[:athlete_profile][:username],
          first_name:params[:athlete_profile][:first_name],
          last_name:params[:athlete_profile][:first_name],
          password:"password"
        )
        user_account.save!

        @athlete = AthleteProfile.new(
          user_id:user_account.id,
          first_name: params[:athlete_profile][:first_name],
          last_name: params[:athlete_profile][:last_name],
          dob: params[:athlete_profile][:dob],
          email:params[:athlete_profile][:email],
          height:params[:athlete_profile][:height],
          weight: params[:athlete_profile][:weight],
          phone:params[:athlete_profile][:phone],
          school_name:params[:athlete_profile][:school_name],
          address: params[:athlete_profile][:address],
          city:params[:athlete_profile][:city],
          power_of_ten: params[:athlete_profile][:power_of_ten],
          level:params[:athlete_profile][:level]
        )
      end

        
          if @athlete.save
            # create_user(@athlete)
            flash[:success] = "AthleteProfile Profile created!"
            redirect_to athlete_profile_path(@athlete)
          else
            flash[:warning] = "Ooops something went wrong!"
            render 'new'
          end


    end

    def athlete_users
      # users = User.where(role: ['athlete', 'parent_role', 'child_athlete'])
      user = User.find(params[:userId])
      render json:user
    end

    def autocomplete
      term = params[:term]
      users = User.where(role: ['athlete', 'parent_role', 'child_athlete']).where("username LIKE ? OR email LIKE ? OR first_name LIKE ? OR last_name LIKE ?", "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%").pluck(:id, :username, :email, :first_name, :last_name)
      render json: users.map { |user| { id: user[0], username: user[1], first_name: user[2], last_name: user[3], email: user[4] } }
    end



    def update

      params[:athlete][:level] = params[:level].to_i

      @athlete = AthleteProfile.find(params[:id])
      if @athlete.update(athlete_params)
        flash[:success] = "AthleteProfile updated"
              redirect_to athlete_path(@athlete)
      else
        render :edit
      end
    end

  private

  def athlete_full_name
    "#{first_name} #{last_name}"
  end

  def full_name=(name)
    parts = name.split(" ", 2)
    self.first_name = parts[0]
    self.last_name = parts[1]
  end

  def athlete_params
    params.require(:athlete_profile).permit(:first_name, :last_name, :dob, :height, :weight, :email, :phone, :school_name, :address,:city, :power_of_ten, :level, :image, :user_id)
  end

end