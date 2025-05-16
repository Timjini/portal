# frozen_string_literal: true

class TimeSlotsController < ApplicationController
  before_action :set_time_slot, only: %i[show edit update destroy]
  load_and_authorize_resource
  include TimeSlotsHelper

  # GET /time_slots or /time_slots.json
  def index
    @time_slots = TimeSlot.all
  end

  # GET /time_slots/1 or /time_slots/1.json
  def show; end

  # GET /time_slots/new
  def new
    @time_slot = TimeSlot.new
  end

  # GET /time_slots/1/edit
  def edit; end

  # POST /time_slots or /time_slots.json
  def create # rubocop:disable Metrics/MethodLength
    coach_ids = params[:time_slot][:user_ids].split(',').map(&:to_i)
    service = TimeslotCreationService.new(time_slot_params, coach_ids)
    result = with_error_handling { service.call }

    respond_to do |format|
      if result
        handle_success(format, result)
      else
        handle_failure(format, result)
      end
    end
  rescue StandardError => e
    Rails.logger.debug { "---> #{e.message}" }
  end

  # PATCH/PUT /time_slots/1 or /time_slots/1.json
  def update # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    apply_to_all = params[:apply_to_all] == '1'

    respond_to do |format|
      if apply_to_all && @time_slot.recurrence_rule.present?
        update_recurrent_timeslots(@time_slot, time_slot_params)
      elsif @time_slot.update(time_slot_params)
        format.html { redirect_to time_slot_url(@time_slot), notice: 'Time slot was successfully updated.' } # rubocop:disable Rails/I18nLocaleTexts
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
      format.html { redirect_to time_slots_url, notice: 'Time slot was successfully destroyed.' } # rubocop:disable Rails/I18nLocaleTexts
      format.json { head :no_content }
    end
  end

  private

  # delete this after debugging
  def with_error_handling
    yield
  rescue StandardError => e
    Rails.logger.debug { "---> #{e.message}" }
  end

  def handle_success(format, result)
    notice = result[:count] ? "#{result[:count]} timeslots created" : 'Timeslot created'
    format.html { redirect_to time_slots_path, notice: notice }
    format.json { render :show, status: :created, location: result[:time_slot] }
  end

  def handle_failure(format, result)
    @time_slot = result[:time_slot] || TimeSlot.new(time_slot_params)
    format.html { render :new, status: :unprocessable_entity }
    format.json { render json: result[:errors], status: :unprocessable_entity }
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_time_slot
    @time_slot = TimeSlot.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def time_slot_params
    params.require(:time_slot).permit(:title, :date, :start_time, :end_time, :slot_type,
                                      :recurrence_rule, :recurrence_end, group_types: [])
  end
end
