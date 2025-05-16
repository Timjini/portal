require 'rails_helper'

RSpec.describe "admins/athlete_levels/new", type: :view do
  before(:each) do
    assign(:athlete_level, Admins::AthleteLevel.new(
      name: "MyString",
      position: 1,
      description: "MyText",
      min_age: 1,
      max_age: 1,
      color: "MyString",
      active: false
    ))
  end

  it "renders new athlete_level form" do
    render

    assert_select "form[action=?][method=?]", admins_athlete_level, "post" do

      assert_select "input[name=?]", "athlete_level[name]"

      assert_select "input[name=?]", "athlete_level[position]"

      assert_select "textarea[name=?]", "athlete_level[description]"

      assert_select "input[name=?]", "athlete_level[min_age]"

      assert_select "input[name=?]", "athlete_level[max_age]"

      assert_select "input[name=?]", "athlete_level[color]"

      assert_select "input[name=?]", "athlete_level[active]"
    end
  end
end
