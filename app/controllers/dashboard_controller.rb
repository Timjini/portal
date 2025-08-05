class DashboardController < ApplicationController
  before_action :authenticate_user!

  # def index # rubocop:disable Metrics/AbcSize
  #   safe_action(:index) do
  #     @children = User.where(parent_id: current_user.id).includes(:athlete_profile, avatar_attachment: :blob)
  #     @notifications = Notification.where(notifiable_id: current_user.id, notifiable_type: 'User', viewed: false)
  #     @displayed_notifications = Notification.where(notifiable_id: current_user.id, notifiable_type: 'User',
  #                                                   viewed: false).last(5)
  #     @daily_logins = UserLogin
  #                     .where(login_at: 7.days.ago.beginning_of_day..Time.current.end_of_day)
  #                     .order('DATE(login_at) DESC')
  #                     .count
  #     @system_alerts_count = AppError.count
  #   end
  # end

  def index
    case current_user.role
    when 'admin'  then redirect_to admin_dashboard_index_path
    when 'coach'  then redirect_to coaches_dashboard_index_path
    when 'parent_user' then redirect_to parents_dashboard_index_path
    when 'child_user'  then redirect_to juniors_dashboard_index_path
    when 'athlete' then redirect_to athletes_dashboard_index_path
    else render 'dashboard'
    end
  end

  def goals_rewards_achievements
    safe_action(:goals_rewards_achievements) do
      # Fetch user goals, rewards, and achievements
    end
  end

  def kpi_csv_upload # rubocop:disable Metrics/MethodLength
    safe_action(:kpi_csv_upload) do
      csv_file = params[:file]
      if csv_file.blank?
        render json: { error: 'No file uploaded' }, status: :bad_request
        return
      end

      saved_file = save_attachments_to_public(csv_file)
      unless saved_file
        render json: { error: 'File upload failed' }, status: :internal_server_error
        return
      end

      csv_service = CsvImportService.new(saved_file)
      csv_service.call do |row|
        process_kpi_data(row)
      end

      render json: { message: 'CSV processed successfully' }, status: :ok
    end
  end

  def process_kpi_data(row) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    safe_action(:process_kpi_data) do
      step = row['step'].to_i
      title = row['title']
      degree = row['degree'].to_i
      category = row['category'].to_i
      checklist = row['checklist']&.split(',')
      service = KpiService.new(title: title, degree: degree, checklist: checklist, category: category, level: step)
      result = service.create_level

      if result[:success]
        Rails.logger.info "Level created successfully: #{result[:level].title}"
      else
        Rails.logger.error "Error creating level: #{result[:errors].join(', ')}"
      end
    end
  end

  def save_attachments_to_public(attachment)
    safe_action(:save_attachments_to_public) do
      return unless attachment.respond_to?(:read)

      attachments_dir = Rails.public_path.join('uploads') # Save under /public/uploads
      FileUtils.mkdir_p(attachments_dir)
      filename = "#{SecureRandom.uuid}#{File.extname(attachment.original_filename)}"
      file_path = attachments_dir.join(filename)

      File.binwrite(file_path, attachment.read)
      Rails.logger.info "File saved successfully: #{file_path}"
      file_path.to_s
    end
  end

  private

  def safe_action(action_name)
    yield
  rescue StandardError => e
    ErrorLogger.log(e, context: {
                      controller: controller_name,
                      action: action_name,
                      params: params.to_unsafe_h,
                      user_id: current_user&.id
                    })
    raise
  end
end
