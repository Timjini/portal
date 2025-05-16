require 'rails_helper'

RSpec.describe "step_exercises/index", type: :view do
  before(:each) do
    assign(:step_exercises, [
      StepExercise.create!(
        step: nil,
        exercise: nil,
        reps: 2,
        sets: 3,
        duration_seconds: 4,
        distance_meters: 5
      ),
      StepExercise.create!(
        step: nil,
        exercise: nil,
        reps: 2,
        sets: 3,
        duration_seconds: 4,
        distance_meters: 5
      )
    ])
  end

  it "renders a list of step_exercises" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(5.to_s), count: 2
  end
end
