# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'step_exercises/edit', type: :view do
  let(:step_exercise) do
    StepExercise.create!(
      step: nil,
      exercise: nil,
      reps: 1,
      sets: 1,
      duration_seconds: 1,
      distance_meters: 1
    )
  end

  before(:each) do
    assign(:step_exercise, step_exercise)
  end

  it 'renders the edit step_exercise form' do
    render

    assert_select 'form[action=?][method=?]', step_exercise_path(step_exercise), 'post' do
      assert_select 'input[name=?]', 'step_exercise[step_id]'

      assert_select 'input[name=?]', 'step_exercise[exercise_id]'

      assert_select 'input[name=?]', 'step_exercise[reps]'

      assert_select 'input[name=?]', 'step_exercise[sets]'

      assert_select 'input[name=?]', 'step_exercise[duration_seconds]'

      assert_select 'input[name=?]', 'step_exercise[distance_meters]'
    end
  end
end
