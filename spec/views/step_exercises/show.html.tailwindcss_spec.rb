# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'step_exercises/show', type: :view do
  before(:each) do
    assign(:step_exercise, StepExercise.create!(
                             step: nil,
                             exercise: nil,
                             reps: 2,
                             sets: 3,
                             duration_seconds: 4,
                             distance_meters: 5
                           ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
  end
end
