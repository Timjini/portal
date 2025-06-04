# frozen_string_literal: true

class ExercisesController < ApplicationController
  load_and_authorize_resource
  before_action :set_exercise, only: %i[show edit update destroy]

  # GET /exercises or /exercises.json
  def index # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    if params[:term].present?
      term = "%#{params[:term]}%"
      @exercises = Exercise.where('name ILIKE :term OR description ILIKE :term', term: term)
      Rails.logger.debug { "--------->, #{params[:term]}" }
    else
      @exercises = Exercise.all.paginate(page: params[:page], per_page: 10)
    end

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  # GET /exercises/1 or /exercises/1.json
  def show; end

  # GET /exercises/new
  def new
    @exercise = Exercise.new
  end

  # GET /exercises/1/edit
  def edit; end

  # POST /exercises or /exercises.json
  def create
    @exercise = Exercise.new(exercise_params)

    respond_to do |format|
      if @exercise.save
        format.html { redirect_to @exercise, notice: 'Exercise was successfully created.' } # rubocop:disable Rails/I18nLocaleTexts
        format.json { render :show, status: :created, location: @exercise }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  def bulk_exercise_upload # rubocop:disable Metrics/MethodLength
    csv_file = params[:file]
    if csv_file.blank?
      render json: { error: 'No file uploaded' }, status: :bad_request
      return
    end

    saved_file = SaveAttachmentToPublic.call(csv_file)
    unless saved_file
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: 'File upload failed', status: :unprocessable_entity }
      return
    end

    csv_service = CsvImportService.new(saved_file)
    csv_service.call do |row|
      Exercise.create!(row)
    end

    render json: { message: 'CSV processed successfully' }, status: :ok
  end

  # PATCH/PUT /exercises/1 or /exercises/1.json
  def update
    respond_to do |format|
      if @exercise.update(exercise_params)
        format.html { redirect_to @exercise, notice: 'Exercise was successfully updated.' } # rubocop:disable Rails/I18nLocaleTexts
        format.json { render :show, status: :ok, location: @exercise }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exercises/1 or /exercises/1.json
  def destroy
    @exercise.destroy!

    respond_to do |format|
      format.html { redirect_to exercises_path, status: :see_other, notice: 'Exercise was successfully destroyed.' } # rubocop:disable Rails/I18nLocaleTexts
      format.json { head :no_content }
    end
  end

  private

  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:name, :description, :reps, :sets, :duration_seconds, :distance_meters,
                                     :male_benchmark, :female_benchmark, :notes, :movement_patterns, :image, :difficulty_level, :intensity, :muscle_group, :primary_focus, :equipment, :video_url, extra_attributes: {}) # rubocop:disable Layout/LineLength
  end
end
