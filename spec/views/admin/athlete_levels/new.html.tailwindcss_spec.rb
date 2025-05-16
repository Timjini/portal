require 'rails_helper'

RSpec.describe "admin/athlete_levels/new", type: :view do
  before(:each) do
    assign(:admin_athlete_level, Admin::AthleteLevel.new(
      name: "MyString",
      position: 1,
      description: "MyText",
      min_age: 1,
      max_age: 1,
      color: "MyString",
      active: false
    ))
  end

  it "renders new admin_athlete_level form" do
    render

    assert_select "form[action=?][method=?]", admin_admins_athlete_level, "post" do

      assert_select "input[name=?]", "admin_athlete_level[name]"

      assert_select "input[name=?]", "admin_athlete_level[position]"

      assert_select "textarea[name=?]", "admin_athlete_level[description]"

      assert_select "input[name=?]", "admin_athlete_level[min_age]"

      assert_select "input[name=?]", "admin_athlete_level[max_age]"

      assert_select "input[name=?]", "admin_athlete_level[color]"

      assert_select "input[name=?]", "admin_athlete_level[active]"
    end
  end
end
