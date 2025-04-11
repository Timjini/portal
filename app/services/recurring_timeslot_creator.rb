# frozen_string_literal: true

class RecurringTimeslotCreator
  def initialize(time_slot, params, calendars)
    @time_slot = time_slot
    @params = params
    @calendars = calendars
  end

  def create
    return handle_non_recurring if @params[:recurrence_rule] == 'none'

    create_recurring_slots
    { success: true }
  rescue StandardError => e
    Rails.logger.error("Recurring timeslot creation failed: #{e.message}")
    { success: false, error: e.message }
  end

  private

  def handle_non_recurring
    if @time_slot.save
      { success: true, time_slot: @time_slot }
    else
      { success: false, errors: @time_slot.errors }
    end
  end

  def create_recurring_slots
    recurrence.events.each do |event_date|
      create_timeslot_for_date(event_date)
    end
  end

  def create_timeslot_for_date(date)
    @calendars.each do |calendar|
      TimeSlot.create(timeslot_attributes(date, calendar))
    end
  end

  def timeslot_attributes(date, calendar) # rubocop:disable Metrics/MethodLength
    {
      title: @params[:title],
      date: date,
      start_time: @time_slot.start_time,
      end_time: @time_slot.end_time,
      recurrence_rule: @time_slot.recurrence_rule,
      recurrence_end: @time_slot.recurrence_end,
      group_types: @time_slot.group_types,
      slot_type: @time_slot.slot_type,
      coach_calendar_id: calendar.id
    }
  end

  def recurrence
    Recurrence.new(recurrence_options)
  end

  def recurrence_options
    {
      every: @params[:recurrence_rule].to_sym,
      on: formatted_day,
      until: recurrence_end
    }.compact
  end

  def formatted_day
    @time_slot.date.strftime('%A').downcase.to_sym
  end

  def recurrence_end
    @params[:recurrence_end].present? ? DateTime.parse(@params[:recurrence_end]) : nil
  end
end
