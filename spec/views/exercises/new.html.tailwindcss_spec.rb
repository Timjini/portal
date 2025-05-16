require 'rails_helper'

RSpec.describe "exercises/new", type: :view do
  before(:each) do
    assign(:exercise, Exercise.new(
      name: "MyString",
      description: "MyText",
      reps: 1,
      sets: 1,
      duration_seconds: 1,
      distance_meters: 1,
      male_benchmark: "MyString",
      female_benchmark: "MyString",
      notes: "MyText",
      movement_patterns: "MyString",
      equipment: "MyString"
    ))
  end

  it "renders new exercise form" do
    render

    assert_select "form[action=?][method=?]", exercises_path, "post" do

      assert_select "input[name=?]", "exercise[name]"

      assert_select "textarea[name=?]", "exercise[description]"

      assert_select "input[name=?]", "exercise[reps]"

      assert_select "input[name=?]", "exercise[sets]"

      assert_select "input[name=?]", "exercise[duration_seconds]"

      assert_select "input[name=?]", "exercise[distance_meters]"

      assert_select "input[name=?]", "exercise[male_benchmark]"

      assert_select "input[name=?]", "exercise[female_benchmark]"

      assert_select "textarea[name=?]", "exercise[notes]"

      assert_select "input[name=?]", "exercise[movement_patterns]"

      assert_select "input[name=?]", "exercise[equipment]"
    end
  end
end
