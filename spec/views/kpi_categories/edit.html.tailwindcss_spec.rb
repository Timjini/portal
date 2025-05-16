require 'rails_helper'

RSpec.describe "kpi_categories/edit", type: :view do
  let(:kpi_category) {
    KpiCategory.create!(
      name: "MyString",
      description: "MyText"
    )
  }

  before(:each) do
    assign(:kpi_category, kpi_category)
  end

  it "renders the edit kpi_category form" do
    render

    assert_select "form[action=?][method=?]", kpi_category_path(kpi_category), "post" do

      assert_select "input[name=?]", "kpi_category[name]"

      assert_select "textarea[name=?]", "kpi_category[description]"
    end
  end
end
