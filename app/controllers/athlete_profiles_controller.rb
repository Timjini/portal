class AthleteProfilesController < ApplicationController
  before_action :authenticate_user!
  skip_forgery_protection only: [:create, :checked_items]
  include NotificationHelper

  # include AthleteProfilesHelper

    def index
      if params[:level].present?
        @athletes = AthleteProfile.includes(:user).where(level: params[:level])
      else
        @athletes = AthleteProfile.includes(:user).all
      end
    end


  def show
    @levels = Level.all.order(:degree,:step)
    @athlete = AthleteProfile.find(params[:id])
    @user = User.find_by(id: @athlete.user_id)

    @athlete_level = @athlete.athlete_level.where(status: "completed")

    @status = {}

    if @athlete_level.blank?  && @levels.present?
      # If athlete_level is nil or blank, enable the first level and disable the rest
      @status[@levels.first] = 'enabled'
      puts "#{@status[@levels.first]}================"
      @levels[1..-1].each { |level| @status[level.id] = 'disabled' }
      puts "#{@levels[1..-1].each { |level| @status[level.id] = 'disabled' }}================"
    else
      # If athlete_level is present, enable the matching level_id and disable non-matching ids
      @levels.each do |level|
        @status[level.id] = @athlete_level.exists?(level_id: level.id) ? 'enabled' : 'disabled'
      end
    end

    user_level = UserLevel.where(user_id: @athlete.user_id)
    @checklist_items_completed = UserChecklist.where(user_id: @athlete.user_id, user_level_id: UserLevel.where(user_id: @athlete.user_id, status: 'completed').pluck(:id), completed: true)


    # Count completed items for the user in all in-progress levels

    # user_level.each do |user_level|
    #   checklist_items = UserChecklist.where(user_id: @athlete.user_id, user_level_id: user_level.id, completed: true).count
    #   level_degree = CheckList.where(level_id: user_level.level_id).count

    #   if checklist_items == level_degree
    #     user_level.update(status: 'completed')
    #     # inform the user that the level is completed by email and notification
    #     message = "Congratulations! You have completed the level #{user_level.level.degree}!"
    #     category = 'level'
    #     general_notification(@user, category, message)
    #   else
    #     user_level.update(status: 'in_progress')
    #   end
    # end


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
      term = params[:term].downcase
      users = User.where(role: ['athlete', 'child_user'])
                  .where("LOWER(username) ILIKE ? OR LOWER(email) ILIKE ? OR LOWER(first_name) ILIKE ? OR LOWER(last_name) ILIKE ?", "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%")
                  .pluck(:id, :username, :email, :first_name, :last_name)

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

      #needed data to update the checklist
      checklist_id = params[:checklist_item][:checklist_id]
      user_id = params[:checklist_item][:user_id]
      completed = params[:checklist_item][:completed]
      @user = User.find(user_id)
      athlete_profile = AthleteProfile.find_by(user_id: user_id)

      # needed variable to check the level of the user
      # user_level = UserLevel.find_by(user_id: user_id)
      check_list = CheckList.find_by(id: checklist_id)



        if check_list.nil?
            render json: { status: 'error', message: 'Checklist not found!' }
            return
        end

          user_checklist = UserChecklist.find_by(check_list_id: checklist_id, user_id: user_id)
          user_level = UserLevel.find_by(user_id: user_id, level_id: check_list.level_id)


          if user_level.nil?
            user_level = UserLevel.create(user_id: user_id, level_id: check_list.level_id, status: 'in_progress', degree: check_list.level.degree)
          end

          if user_checklist.present?
            puts "YES =============="
            user_checklist.update(completed: completed)
          else
            puts "NO =============="
            UserChecklist.create(check_list_id: checklist_id, user_id: user_id, completed: completed, user_level_id: user_level.id,title: check_list.title)
          end

           user_levels = UserLevel.where(user_id: user_id, degree: check_list.level.degree)
            checklist_items = UserChecklist.where(user_id: user_id, user_level_id: user_levels.pluck(:id), completed: true).count

            level_degree = CheckList.joins(:level).where(levels: { degree: user_levels.pluck(:degree) }).count

            if checklist_items == level_degree
              user_levels.update_all(status: 'completed') 
              athlete_profile.update(level: user_levels.first.level.degree) # Assuming you want to update athlete_profile with the degree of the first matching user level
              puts "Updated #{athlete_profile} =========="
              # Inform the user that the level is completed by email and notification
              message = "Congratulations! You have completed the level #{user_levels.first.level.degree}!"
              category = 'level'
              general_notification(@user, category, message)
            else
              user_levels.update_all(status: 'in_progress')
              athlete_profile.update(level: user_levels.first.level.degree) # Assuming you want to update athlete_profile with the degree of the first matching user level
            end

          respond_to do |format|
            format.turbo_stream
          end

          render json: { status: 'success', message: 'Checklist updated!' }
    end



  private


  def athlete_params
    params.require(:athlete_profile).permit(:first_name, :last_name, :dob, :height, :weight, :email, :phone, :school_name, :address,:city, :power_of_ten, :level, :image, :user_id)
  end

end