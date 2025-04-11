# frozen_string_literal: true

class TimeslotCreationService
  def initialize(time_slot_params, coach_ids)
    @time_slot_params = time_slot_params
    @coach_ids = coach_ids
    @time_slot = TimeSlot.new(time_slot_params.except(:user_ids))
  end

  def call
    if recurring?
      create_recurring_timeslots
    else
      save_single_timeslot
    end
  end

  private

  def recurring?
    rule = @time_slot_params[:recurrence_rule].to_s
    %w[day week month].include?(rule)
  end

  def create_recurring_timeslots
    calendars = Calendar::CalendarService.find_or_create_calendars(@coach_ids)
    RecurringTimeslotCreator.new(@time_slot, @time_slot_params, calendars).create
  end

  def save_single_timeslot # rubocop:disable Metrics/MethodLength
    TimeSlot.transaction do
      calendars = Calendar::CalendarService.find_or_create_calendars(@coach_ids)
      @time_slot.coach_calendar = calendars.first
      if @time_slot.save
        { success: true, time_slot: @time_slot }
      else
        { success: false, errors: @time_slot.errors }
      end
    end
  rescue StandardError => e
    { success: false, errors: [e.message] }
  end
end
