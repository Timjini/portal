# frozen_string_literal: true

class CompetitionsController < ApplicationController
  before_action :set_competition, only: %i[show edit update destroy]
  load_and_authorize_resource

  # GET /competitions or /competitions.json
  def index
    @competitions = Competition.where('date > ?', Time.zone.today)
  end

  # GET /competitions/1 or /competitions/1.json
  def show; end

  # GET /competitions/new
  def new
    @competition = Competition.new
  end

  # GET /competitions/1/edit
  def edit; end

  # POST /competitions or /competitions.json
  def create # rubocop:disable Metrics/MethodLength
    @competition = Competition.new(competition_params)

    respond_to do |format|
      if @competition.save
        # rubocop:disable Rails/I18nLocaleTexts
        format.html do
          redirect_to competition_path(@competition), notice: 'Competition was successfully created.'
        end
        format.json { render :show, status: :created, location: @competition }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @competition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /competitions/1 or /competitions/1.json
  def update # rubocop:disable Metrics/MethodLength
    respond_to do |format|
      if @competition.update(competition_params)
        # rubocop:disable Rails/I18nLocaleTexts,Lint/MissingCopEnableDirective
        format.html do
          redirect_to competition_path(@competition), notice: 'Competition was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @competition }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @competition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /competitions/1 or /competitions/1.json
  def destroy
    @competition.destroy!

    respond_to do |format|
      format.html do
        redirect_to competitions_path, status: :see_other, notice: 'Competition was successfully destroyed.' # rubocop:disable Rails/I18nLocaleTexts
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_competition
    @competition = Competition.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def competition_params
    params.require(:competition).permit(:title, :date, :link, :image, :status)
  end
end
