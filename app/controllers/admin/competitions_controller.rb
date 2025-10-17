# frozen_string_literal: true

module Admin
  class CompetitionsController < ApplicationController
    before_action :set_competition, only: %i[show edit update destroy]
     before_action :authenticate_user!

    # GET /competitions or /competitions.json
    def index
      @competitions = Competition.all
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
    def create
      @competition = Competition.new(competition_params)

      respond_to do |format|
        if @competition.save
          format.html { redirect_to admin_competition_path(@competition), notice: 'Competition was successfully created.' } # rubocop:disable Rails/I18nLocaleTexts
          format.json { render :show, status: :created, location: @competition }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @competition.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /competitions/1 or /competitions/1.json
    def update
      respond_to do |format|
        if @competition.update(competition_params)
          format.html { redirect_to admin_competition_path(@competition), notice: 'Competition was successfully updated.' } # rubocop:disable Rails/I18nLocaleTexts
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
          redirect_to admin_competitions_path, status: :see_other, notice: 'Competition was successfully destroyed.' # rubocop:disable Rails/I18nLocaleTexts
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
      params.require(:competition).permit(:title, :date, :link)
    end
  end
end
