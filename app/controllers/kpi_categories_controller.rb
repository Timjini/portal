# frozen_string_literal: true

class KpiCategoriesController < ApplicationController
  before_action :set_kpi_category, only: %i[show edit update destroy]

  # GET /kpi_categories or /kpi_categories.json
  def index
    @kpi_categories = KpiCategory.all
  end

  # GET /kpi_categories/1 or /kpi_categories/1.json
  def show; end

  # GET /kpi_categories/new
  def new
    @kpi_category = KpiCategory.new
  end

  # GET /kpi_categories/1/edit
  def edit; end

  # POST /kpi_categories or /kpi_categories.json
  def create
    @kpi_category = KpiCategory.new(kpi_category_params)

    respond_to do |format|
      if @kpi_category.save
        format.html { redirect_to @kpi_category, notice: 'Kpi category was successfully created.' }
        format.json { render :show, status: :created, location: @kpi_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @kpi_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kpi_categories/1 or /kpi_categories/1.json
  def update
    respond_to do |format|
      if @kpi_category.update(kpi_category_params)
        format.html { redirect_to @kpi_category, notice: 'Kpi category was successfully updated.' }
        format.json { render :show, status: :ok, location: @kpi_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @kpi_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kpi_categories/1 or /kpi_categories/1.json
  def destroy
    @kpi_category.destroy!

    respond_to do |format|
      format.html do
        redirect_to kpi_categories_path, status: :see_other, notice: 'Kpi category was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_kpi_category
    @kpi_category = KpiCategory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def kpi_category_params
    params.require(:kpi_category).permit(:name, :description)
  end
end
