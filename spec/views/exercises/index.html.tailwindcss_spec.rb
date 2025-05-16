require 'rails_helper'

RSpec.describe "exercises/index", type: :view do
  before(:each) do
    assign(:exercises, [
      Exercise.create!(
        name: "Name",
        description: "MyText",
        reps: 2,
        sets: 3,
        duration_seconds: 4,
        distance_meters: 5,
        male_benchmark: "Male Benchmark",
        female_benchmark: "Female Benchmark",
        notes: "MyText",
        movement_patterns: "Movement Patterns",
        equipment: "Equipment"
      ),
      Exercise.create!(
        name: "Name",
        description: "MyText",
        reps: 2,
        sets: 3,
        duration_seconds: 4,
        distance_meters: 5,
        male_benchmark: "Male Benchmark",
        female_benchmark: "Female Benchmark",
        notes: "MyText",
        movement_patterns: "Movement Patterns",
        equipment: "Equipment"
      )
    ])
  end

  it "renders a list of exercises" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(5.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Male Benchmark".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Female Benchmark".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Movement Patterns".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Equipment".to_s), count: 2
  end
end
