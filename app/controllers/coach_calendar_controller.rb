# frozen_string_literal: true

class CoachCalendarController < ApplicationController
  def index
    service = Calendar::CoachCalendarService.new
    @calendar = service.fetch_all_calendars_only
  end

  def show
    service = Calendar::CoachCalendarService.new(params)
    @calendar = service.fetch_calendar_with_time_slots
  end

  def calendar_data
    service = Calendar::CoachCalendarService.new(params)
    result = service.fetch_calendar_by_user

    if result
      render json: result[:time_slots]
    else
      render json: { error: "No calendar found for user with ID #{params[:user_id]}" }, status: :not_found
    end
  rescue StandardError => e
    Rails.logger.debug { "---> #{e.message}" }
  end

  def all_calendars
    service = Calendar::CoachCalendarService.new
    result = service.fetch_all_calendars

    if result.empty?
      render json: { error: 'No calendar found' }, status: :not_found
    else
      render json: result
    end
  end
end
