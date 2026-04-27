class AccountService
  def initialize(params)
    @params = params
  end

  def register
    ActiveRecord::Base.transaction do
      @user = User.create!(user_params)

      # Merge the new user's ID into the athlete params
      AthleteProfile.create!(athlete_params.merge(user_id: @user.id))
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Registration failed: #{e.message}")
  end

  private

  def athlete_params
    {
      dob: @params[:dob],
      school_name: @params[:school_name],
      height: @params[:height],
      weight: @params[:weight],
      first_name: @params[:first_name],
      last_name: @params[:last_name]
    }
  end

  def user_params
    {
      email: @params[:email],
      parent_id: @params[:user_id],
      first_name: @params[:first_name],
      last_name: @params[:last_name],
      username: @params[:username].downcase,
      password: @params[:password],
      avatar: @params[:avatar],
      role: 'child_user'
    }
  end
end
