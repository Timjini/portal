# frozen_string_literal: true

class AthleteLevelCategoriesController < ApplicationController
  before_action :set_athlete_level_category, only: %i[show edit update destroy]
  load_and_authorize_resource

  # GET /athlete_level_categories or /athlete_level_categories.json
  def index
    @athlete_level_categories = AthleteLevelCategory.includes(%i[athlete_level kpi_category])
  end

  # GET /athlete_level_categories/1 or /athlete_level_categories/1.json
  def show; end

  # GET /athlete_level_categories/new
  def new
    @athlete_level_category = AthleteLevelCategory.new
  end

  # GET /athlete_level_categories/1/edit
  def edit; end

  # POST /athlete_level_categories or /athlete_level_categories.json
  def create
    @athlete_level_category = AthleteLevelCategory.new(athlete_level_category_params)

    respond_to do |format|
      if @athlete_level_category.save
        format.html { redirect_to @athlete_level_category, notice: 'Athlete level category was successfully created.' } # rubocop:disable Rails/I18nLocaleTexts
        format.json { render :show, status: :created, location: @athlete_level_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @athlete_level_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /athlete_level_categories/1 or /athlete_level_categories/1.json
  def update
    respond_to do |format|
      if @athlete_level_category.update(athlete_level_category_params)
        format.html { redirect_to @athlete_level_category, notice: 'Athlete level category was successfully updated.' } # rubocop:disable Rails/I18nLocaleTexts
        format.json { render :show, status: :ok, location: @athlete_level_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @athlete_level_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /athlete_level_categories/1 or /athlete_level_categories/1.json
  def destroy
    @athlete_level_category.destroy!

    respond_to do |format|
      format.html do
        redirect_to athlete_level_categories_path, status: :see_other,
                                                   notice: 'Athlete level category was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_athlete_level_category
    @athlete_level_category = AthleteLevelCategory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def athlete_level_category_params
    params.require(:athlete_level_category).permit(:athlete_level_id, :kpi_category_id)
  end
end
