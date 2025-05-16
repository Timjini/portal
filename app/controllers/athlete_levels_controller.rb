# frozen_string_literal: true

class AthleteLevelsController < ApplicationController
  load_and_authorize_resource
  before_action :set_athlete_level, only: %i[show edit update destroy]

  # GET /athlete_levels or /athlete_levels.json
  def index
    @athlete_levels = AthleteLevel.order(:position)
  end

  # GET /athlete_levels/1 or /athlete_levels/1.json
  def show; end

  # GET /athlete_levels/new
  def new
    @athlete_level = AthleteLevel.new
  end

  # GET /athlete_levels/1/edit
  def edit; end

  # POST /athlete_levels or /athlete_levels.json
  def create
    @athlete_level = AthleteLevel.new(athlete_level_params)

    respond_to do |format|
      if @athlete_level.save
        format.html { redirect_to @athlete_level, notice: 'Athlete level was successfully created.' }
        format.json { render :show, status: :created, location: @athlete_level }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @athlete_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /athlete_levels/1 or /athlete_levels/1.json
  def update
    respond_to do |format|
      if @athlete_level.update(athlete_level_params)
        format.html { redirect_to @athlete_level, notice: 'Athlete level was successfully updated.' }
        format.json { render :show, status: :ok, location: @athlete_level }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @athlete_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /athlete_levels/1 or /athlete_levels/1.json
  def destroy
    @athlete_level.destroy!

    respond_to do |format|
      format.html do
        redirect_to athlete_levels_path, status: :see_other, notice: 'Athlete level was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_athlete_level
    @athlete_level = AthleteLevel.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def athlete_level_params
    params.require(:athlete_level).permit(:name, :position, :description, :min_age, :max_age, :color, :active)
  end
end
