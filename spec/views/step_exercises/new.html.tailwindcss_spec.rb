require 'rails_helper'

RSpec.describe "step_exercises/new", type: :view do
  before(:each) do
    assign(:step_exercise, StepExercise.new(
      step: nil,
      exercise: nil,
      reps: 1,
      sets: 1,
      duration_seconds: 1,
      distance_meters: 1
    ))
  end

  it "renders new step_exercise form" do
    render

    assert_select "form[action=?][method=?]", step_exercises_path, "post" do

      assert_select "input[name=?]", "step_exercise[step_id]"

      assert_select "input[name=?]", "step_exercise[exercise_id]"

      assert_select "input[name=?]", "step_exercise[reps]"

      assert_select "input[name=?]", "step_exercise[sets]"

      assert_select "input[name=?]", "step_exercise[duration_seconds]"

      assert_select "input[name=?]", "step_exercise[distance_meters]"
    end
  end
end
