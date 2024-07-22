class TimeSlotsController < ApplicationController
  before_action :set_time_slot, only: %i[ show edit update destroy ]
  include TimeSlotsHelper

  # GET /time_slots or /time_slots.json
  def index
    @time_slots = TimeSlot.all
  end

  # GET /time_slots/1 or /time_slots/1.json
  def show
  end

  # GET /time_slots/new
  def new
    @time_slot = TimeSlot.new
  end

  # GET /time_slots/1/edit
  def edit
  end

  # POST /time_slots or /time_slots.json
  def create
    user_ids = params[:time_slot][:user_ids].split(',')
    @time_slot = TimeSlot.new(time_slot_params)

    existing_calendars = CoachCalendar.where(user_id: user_ids).to_a

    existing_user_ids = existing_calendars.map(&:user_id).uniq
    integers_array = []
    user_ids.each { |user_id| integers_array << user_id.to_i }
    missing_user_ids = integers_array - existing_user_ids
    
    missing_calendars = missing_user_ids.map do |user_id|
      CoachCalendar.create(user_id: user_id)
    end

    all_calendars = existing_calendars + missing_calendars

    @time_slot.coach_calendar_ids = all_calendars.map(&:id)

    if params[:time_slot][:recurrence_rule].present?
      create_recurrent_timeslots(@time_slot, params[:time_slot][:recurrence_rule], params[:time_slot][:recurrence_end])
    else
      save_time_slot(@time_slot)
    end
  end



  # PATCH/PUT /time_slots/1 or /time_slots/1.json
  def update
    apply_to_all = params[:apply_to_all] == '1'

    respond_to do |format|
      if apply_to_all && @time_slot.recurrence_rule.present?
        update_recurrent_timeslots(@time_slot, time_slot_params)
      elsif @time_slot.update(time_slot_params)
        format.html { redirect_to time_slot_url(@time_slot), notice: "Time slot was successfully updated." }
        format.json { render :show, status: :ok, location: @time_slot }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @time_slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_slots/1 or /time_slots/1.json
  def destroy
    @time_slot.destroy!

    respond_to do |format|
      format.html { redirect_to time_slots_url, notice: "Time slot was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_slot
      @time_slot = TimeSlot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def time_slot_params
      params.require(:time_slot).permit(:coach_calendar_ids, :date, :start_time, :end_time,:slot_type, :recurrence_rule, :recurrence_end,group_types: [], user_ids: [])
    end
end
