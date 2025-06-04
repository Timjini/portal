# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'exercises/index', type: :view do # rubocop:disable Metrics/BlockLength
  before(:each) do # rubocop:disable Metrics/BlockLength
    assign(:exercises, [
             Exercise.create!(
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
             ),
             Exercise.create!(
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
             )
           ])
  end

  it 'renders a list of exercises' do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new('Name'), count: 2
    assert_select cell_selector, text: Regexp.new('MyText'), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(5.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Male Benchmark'), count: 2
    assert_select cell_selector, text: Regexp.new('Female Benchmark'), count: 2
    assert_select cell_selector, text: Regexp.new('MyText'), count: 2
    assert_select cell_selector, text: Regexp.new('Movement Patterns'), count: 2
    assert_select cell_selector, text: Regexp.new('Equipment'), count: 2
  end
end
