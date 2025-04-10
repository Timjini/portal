# frozen_string_literal: true

require 'rubygems'
require 'recurrence'

module TimeSlotsHelper
  def create_recurrent_timeslots(time_slot, title, recurrence_rule, recurrence_end, calendar) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    recurrence_end = DateTime.parse(recurrence_end) if recurrence_end.present?
    if recurrence_rule == 'none'
      save_time_slot(time_slot)
    else
      day = time_slot.date
      formatted_day = day.strftime('%A').downcase.to_sym
      recurrence_rule_hash = { every: recurrence_rule.to_sym, on: formatted_day, until: recurrence_end }.compact
      recurrence = Recurrence.new(recurrence_rule_hash)
      recurrence.events.each do |event_date|
        TimeSlot.create(
          title: title,
          date: event_date,
          start_time: time_slot.start_time,
          end_time: time_slot.end_time,
          recurrence_rule: time_slot.recurrence_rule,
          recurrence_end: time_slot.recurrence_end,
          group_types: time_slot.group_types,
          slot_type: time_slot.slot_type,
          coach_calendar_id: calendar.id
        )
      end
      redirect_to time_slots_path, notice: 'Recurrent timeslots were successfully created.' # rubocop:disable Rails/I18nLocaleTexts
    end
  rescue StandardError => e
    Rails.logger.debug { " =>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ERROR: #{e.message}" }
    raise e
  end

  def save_time_slot(time_slot)
    respond_to do |format|
      if time_slot.save
        format.html { redirect_to time_slot_url(time_slot), notice: 'Time slot was successfully created.' } # rubocop:disable Rails/I18nLocaleTexts
        format.json { render :show, status: :created, location: time_slot }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: time_slot.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_recurrent_timeslots(original_time_slot, time_slot_params)
    timeslots = Timeslot.where(
      # 'coach_calendar_ids = ? AND start_time >= ? AND recurrence_rule = ?',
      # original_time_slot.coach_calendar_ids,
      original_time_slot.start_time,
      original_time_slot.recurrence_rule
    )

    timeslots.each do |timeslot|
      timeslot.update(time_slot_params)
    end

    redirect_to time_slots_path, notice: 'Recurring timeslots were successfully updated.' # rubocop:disable Rails/I18nLocaleTexts
  end
end
