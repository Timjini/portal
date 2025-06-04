# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'exercises/edit', type: :view do # rubocop:disable Metrics/BlockLength
  let(:exercise) do
    Exercise.create!(
      name: 'MyString',
      description: 'MyText',
      reps: 1,
      sets: 1,
      duration_seconds: 1,
      distance_meters: 1,
      male_benchmark: 'MyString',
      female_benchmark: 'MyString',
      notes: 'MyText',
      movement_patterns: 'MyString',
      equipment: 'MyString'
    )
  end

  before(:each) do
    assign(:exercise, exercise)
  end

  it 'renders the edit exercise form' do
    render

    assert_select 'form[action=?][method=?]', exercise_path(exercise), 'post' do
      assert_select 'input[name=?]', 'exercise[name]'

      assert_select 'textarea[name=?]', 'exercise[description]'

      assert_select 'input[name=?]', 'exercise[reps]'

      assert_select 'input[name=?]', 'exercise[sets]'

      assert_select 'input[name=?]', 'exercise[duration_seconds]'

      assert_select 'input[name=?]', 'exercise[distance_meters]'

      assert_select 'input[name=?]', 'exercise[male_benchmark]'

      assert_select 'input[name=?]', 'exercise[female_benchmark]'

      assert_select 'textarea[name=?]', 'exercise[notes]'

      assert_select 'input[name=?]', 'exercise[movement_patterns]'

      assert_select 'input[name=?]', 'exercise[equipment]'
    end
  end
end
