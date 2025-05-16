require 'rails_helper'

RSpec.describe "athlete_level_categories/index", type: :view do
  before(:each) do
    assign(:athlete_level_categories, [
      AthleteLevelCategory.create!(
        athlete_level: nil,
        kpi_category: nil
      ),
      AthleteLevelCategory.create!(
        athlete_level: nil,
        kpi_category: nil
      )
    ])
  end

  it "renders a list of athlete_level_categories" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
