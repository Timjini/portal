class StepExercisesController < ApplicationController
  before_action :set_step_exercise, only: %i[ show edit update destroy ]

  # GET /step_exercises or /step_exercises.json
  def index
    @step_exercises = StepExercise.all
  end

  # GET /step_exercises/1 or /step_exercises/1.json
  def show
  end

  # GET /step_exercises/new
  def new
    @step_exercise = StepExercise.new
  end

  # GET /step_exercises/1/edit
  def edit
  end

  # POST /step_exercises or /step_exercises.json
  def create
    @step_exercise = StepExercise.new(step_exercise_params)

    respond_to do |format|
      if @step_exercise.save
        format.html { redirect_to @step_exercise, notice: "Step exercise was successfully created." }
        format.json { render :show, status: :created, location: @step_exercise }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @step_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /step_exercises/1 or /step_exercises/1.json
  def update
    respond_to do |format|
      if @step_exercise.update(step_exercise_params)
        format.html { redirect_to @step_exercise, notice: "Step exercise was successfully updated." }
        format.json { render :show, status: :ok, location: @step_exercise }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @step_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /step_exercises/1 or /step_exercises/1.json
  def destroy
    @step_exercise.destroy!

    respond_to do |format|
      format.html { redirect_to step_exercises_path, status: :see_other, notice: "Step exercise was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_step_exercise
      @step_exercise = StepExercise.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def step_exercise_params
      params.require(:step_exercise).permit(:step_id, :exercise_id, :reps, :sets, :duration_seconds, :distance_meters)
    end
end
