# frozen_string_literal: true

class StepsController < ApplicationController
  before_action :set_step, only: %i[show edit update destroy]
  load_and_authorize_resource

  # GET /steps or /steps.json
  def index
    @steps = Step.includes(%i[exercises athlete_level_category])
  end

  # GET /steps/1 or /steps/1.json
  def show; end

  # GET /steps/new
  def new
    @step = Step.new
  end

  # GET /steps/1/edit
  def edit; end

  # POST /steps or /steps.json
  def create
    @step = Step.new(step_params)

    respond_to do |format|
      if @step.save
        format.html { redirect_to @step, notice: 'Step was successfully created.' } # rubocop:disable Rails/I18nLocaleTexts
        format.json { render :show, status: :created, location: @step }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /steps/1 or /steps/1.json
  def update
    respond_to do |format|
      if @step.update(step_params)
        format.html { redirect_to @step, notice: 'Step was successfully updated.' } # rubocop:disable Rails/I18nLocaleTexts
        format.json { render :show, status: :ok, location: @step }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /steps/1 or /steps/1.json
  def destroy
    @step.destroy!

    respond_to do |format|
      format.html { redirect_to steps_path, status: :see_other, notice: 'Step was successfully destroyed.' } # rubocop:disable Rails/I18nLocaleTexts
      format.json { head :no_content }
    end
  end

  private

  def set_step
    @step = Step.find(params[:id])
  end

  def step_params
    params.require(:step).permit(:athlete_level_category_id, :step_number)
  end
end
