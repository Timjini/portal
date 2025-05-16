require 'rails_helper'

RSpec.describe "kpi_categories/show", type: :view do
  before(:each) do
    assign(:kpi_category, KpiCategory.create!(
      name: "Name",
      description: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
