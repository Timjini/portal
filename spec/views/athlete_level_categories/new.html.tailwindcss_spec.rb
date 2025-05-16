require 'rails_helper'

RSpec.describe "athlete_level_categories/new", type: :view do
  before(:each) do
    assign(:athlete_level_category, AthleteLevelCategory.new(
      athlete_level: nil,
      kpi_category: nil
    ))
  end

  it "renders new athlete_level_category form" do
    render

    assert_select "form[action=?][method=?]", athlete_level_categories_path, "post" do

      assert_select "input[name=?]", "athlete_level_category[athlete_level_id]"

      assert_select "input[name=?]", "athlete_level_category[kpi_category_id]"
    end
  end
end
