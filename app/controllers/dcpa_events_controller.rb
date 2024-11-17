# frozen_string_literal: true

class DcpaEventsController < ApplicationController # rubocop:disable Style/Documentation
  before_action :set_dcpa_event, only: %i[ show edit update destroy ]

  # GET /dcpa_events or /dcpa_events.json
  def index
    @dcpa_events = DcpaEvent.all
  end

  # GET /dcpa_events/1 or /dcpa_events/1.json
  def show; end

  # GET /dcpa_events/new
  def new
    @dcpa_event = DcpaEvent.new
  end

  # GET /dcpa_events/1/edit
  def edit; end

  # POST /dcpa_events or /dcpa_events.json
  def create
    @dcpa_event = DcpaEvent.new(dcpa_event_params)

    respond_to do |format|
      if @dcpa_event.save
        format.html { redirect_to @dcpa_event, notice: 'Dcpa event was successfully created.' }
        format.json { render :show, status: :created, location: @dcpa_event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dcpa_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dcpa_events/1 or /dcpa_events/1.json
  def update
    respond_to do |format|
      if @dcpa_event.update(dcpa_event_params)
        format.html { redirect_to @dcpa_event, notice: 'Dcpa event was successfully updated.' }
        format.json { render :show, status: :ok, location: @dcpa_event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dcpa_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dcpa_events/1 or /dcpa_events/1.json
  def destroy
    @dcpa_event.destroy!

    respond_to do |format|
      format.html { redirect_to dcpa_events_path, status: :see_other, notice: 'Dcpa event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dcpa_event
    @dcpa_event = DcpaEvent.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def dcpa_event_params
    params.require(:dcpa_event).permit(:title, :coach, :time_start, :time_end, :location, :ages_available, :price, 
                                       :dcpa_discount, :extras, :event_type, dates: [])
  end
end
