require 'rails_helper'

RSpec.describe "steps/show", type: :view do
  before(:each) do
    assign(:step, Step.create!(
      athlete_level: nil,
      kpi_category: nil,
      step_number: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
  end
end
