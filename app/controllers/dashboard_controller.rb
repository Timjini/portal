# frozen_string_literal: true

require 'fileutils'
require 'open-uri'

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @children = User.where(parent_id: current_user.id)
    @notifications = Notification.where(notifiable_id: current_user.id, notifiable_type: 'User', viewed: false)
    @displayed_notifications = Notification.where(notifiable_id: current_user.id, notifiable_type: 'User',
                                                  viewed: false).last(5)
  end

  def goals_rewards_acheivements; end

  def kpi_csv_upload
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

  def process_kpi_data(row) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    row['level']
    step = row['step'].to_i
    title = row['title']
    degree = row['degree'].to_i
    category = row['category'].to_i
    checklist = row['checklist'].split(',')
    service = KpiService.new(title: title, degree: degree, checklist: checklist, category: category, level: step)
    result = service.create_level

    if result[:success]
      Rails.logger.info "Level created successfully: #{result[:level].title}"
    else
      Rails.logger.error "Error creating level: #{result[:errors].join(', ')}"
    end
  end

  def save_attachments_to_public(attachment)
    return unless attachment.respond_to?(:read)

    attachments_dir = Rails.public_path.join('uploads') # Save under /public/uploads
    FileUtils.mkdir_p(attachments_dir)
    filename = "#{SecureRandom.uuid}#{File.extname(attachment.original_filename)}"
    file_path = attachments_dir.join(filename)

    begin
      File.binwrite(file_path, attachment.read)
      Rails.logger.info "File saved successfully: #{file_path}"
      file_path.to_s
    rescue StandardError => e
      Rails.logger.error "Error saving attachment: #{e.message}"
      nil
    end
  end
end
