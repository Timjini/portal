require 'rails_helper'

RSpec.describe "admin/kpi_categories/index", type: :view do
  before(:each) do
    assign(:admin_kpi_categories, [
      Admin::KpiCategory.create!(
        name: "Name",
        description: "MyText"
      ),
      Admin::KpiCategory.create!(
        name: "Name",
        description: "MyText"
      )
    ])
  end

  it "renders a list of admin/kpi_categories" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  end
end
