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
    @time_slot = TimeSlot.new(time_slot_params)
    @calendar = CoachCalendar.where(user_id: current_user.id).first_or_create
    @time_slot.coach_calendar_id = @calendar.id

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
      params.require(:time_slot).permit(:coach_calendar_id, :date, :start_time, :end_time, :group_type,:slot_type, :recurrence_rule, :recurrence_end)
    end
end
