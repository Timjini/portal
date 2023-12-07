class AthleteProfilesController < ApplicationController
  before_action :authenticate_user!
  skip_forgery_protection only: [:create, :checked_items]

  # include AthleteProfilesHelper

    def index
      if params[:level].present?
        @athletes = AthleteProfile.includes(:user).where(level: params[:level])
      else
        @athletes = AthleteProfile.includes(:user).all
      end
    end


  def show
    @levels = Level.all
    @athlete = AthleteProfile.find(params[:id])
    @user = User.find_by(id: @athlete.user_id)

    respond_to do |format|
      format.html # Your regular HTML response
      format.turbo_stream # Turbo Streams response for Turbo Frames
    end
  end


    def edit
    @athlete = AthleteProfile.find(params[:id])
    end

    def new
      @athlete = AthleteProfile.new
    end

   def create
      params[:athlete_profile][:level] = params[:level].to_i

      user = User.find_by(id: params[:athlete_profile][:user_id])
      existing_profile = AthleteProfile.find_by(user_id: params[:athlete_profile][:user_id])

      if existing_profile.present?
        existing_profile.update(athlete_params)
        flash[:warning] = "Account has been updated!"
        redirect_to dashboard_path
      elsif user.present?
        @athlete = AthleteProfile.create(athlete_params)

        if @athlete.persisted?
          flash[:success] = "Athlete Profile created!"
          redirect_to athlete_profile_path(@athlete)
        else
          flash[:warning] = "Ooops something went wrong!"
          render 'new'
        end
      else
        flash[:warning] = "User not found with the provided user_id!"
        redirect_to new_athlete_profile_path
      end
    end



    def athlete_users
      # users = User.where(role: ['athlete', 'parent_role', 'child_athlete'])
      user = User.find(params[:userId])
      render json:user
    end

    def autocomplete
      term = params[:term]
      users = User.where(role: ['athlete','child_user']).where("username LIKE ? OR email LIKE ? OR first_name LIKE ? OR last_name LIKE ?", "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%").pluck(:id, :username, :email, :first_name, :last_name)
      render json: users.map { |user| { id: user[0], username: user[1], first_name: user[2], last_name: user[3], email: user[4] } }
    end

    def edit
      @athlete = AthleteProfile.find(params[:id])
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


    # Routes for Users Checked items 
    def checked_items
      checklist_id = params[:checklist_item][:checklist_id]
      user_id = params[:checklist_item][:user_id]
      completed = params[:checklist_item][:completed]

      check_list = CheckList.find_by(id: checklist_id)

        if check_list.nil?
            render json: { status: 'error', message: 'Checklist not found!' }
          else

          user_checklist = UserChecklist.find_by(check_list_id: checklist_id, user_id: user_id)
          user_level = UserLevel.find_by(user_id: user_id, level_id: check_list.level_id)

          if user_level.nil?
            user_level = UserLevel.create(user_id: user_id, user_level_id: check_list.level_id)

          end

          if user_checklist.present?
            user_checklist.update(completed: completed)
          else
            UserChecklist.create(check_list_id: checklist_id, user_id: user_id, completed: completed, user_level_id: user_level.id)
          end

        end

        render json: { status: 'success', message: 'Checklist updated!' }

        
    end



  private

  def athlete_full_name
    "#{first_name} #{last_name}"
  end

  # def full_name=(name)
  #   parts = name.split(" ", 2)
  #   self.first_name = parts[0]
  #   self.last_name = parts[1]
  # end

  def athlete_params
    params.require(:athlete_profile).permit(:first_name, :last_name, :dob, :height, :weight, :email, :phone, :school_name, :address,:city, :power_of_ten, :level, :image, :user_id)
  end

end