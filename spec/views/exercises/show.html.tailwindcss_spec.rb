# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'exercises/show', type: :view do # rubocop:disable Metrics/BlockLength
  before(:each) do
    assign(:exercise, Exercise.create!(
                        name: 'Name',
                        description: 'MyText',
                        reps: 2,
                        sets: 3,
                        duration_seconds: 4,
                        distance_meters: 5,
                        male_benchmark: 'Male Benchmark',
                        female_benchmark: 'Female Benchmark',
                        notes: 'MyText',
                        movement_patterns: 'Movement Patterns',
                        equipment: 'Equipment'
                      ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/Male Benchmark/)
    expect(rendered).to match(/Female Benchmark/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Movement Patterns/)
    expect(rendered).to match(/Equipment/)
  end
end
