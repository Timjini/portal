require "rubygems"
require "recurrence"

module TimeSlotsHelper
    def create_recurrent_timeslots(time_slot, recurrence_rule, recurrence_end)
    recurrence_end = DateTime.parse(recurrence_end) if recurrence_end.present?
    recurrence_rule = { every: recurrence_rule.to_sym,  until: recurrence_end }.compact

    byebug

    recurrence = Recurrence.new(recurrence_rule.merge(starts: time_slot.start_time))

    recurrence.events.each do |event_date|
      Timeslot.create(
        start_time: event_date,
        end_time: event_date + (time_slot.end_time - time_slot.start_time),
        coach_calendar_id: time_slot.coach_calendar_id,
        recurrence_rule: time_slot.recurrence_rule,
        recurrence_end: time_slot.recurrence_end
      )
    end

    redirect_to timeslots_path, notice: 'Recurrent timeslots were successfully created.'
  end

   def save_time_slot(time_slot)
    respond_to do |format|
      if time_slot.save
        format.html { redirect_to time_slot_url(time_slot), notice: "Time slot was successfully created." }
        format.json { render :show, status: :created, location: time_slot }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: time_slot.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_recurrent_timeslots(original_time_slot, time_slot_params)
    timeslots = Timeslot.where(
      "coach_calendar_id = ? AND start_time >= ? AND recurrence_rule = ?",
      original_time_slot.coach_calendar_id,
      original_time_slot.start_time,
      original_time_slot.recurrence_rule
    )

    # Update each timeslot with the new parameters
    timeslots.each do |timeslot|
      timeslot.update(time_slot_params)
    end

    redirect_to timeslots_path, notice: 'Recurring timeslots were successfully updated.'
  end

end
