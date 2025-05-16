require 'rails_helper'

RSpec.describe "steps/index", type: :view do
  before(:each) do
    assign(:steps, [
      Step.create!(
        athlete_level: nil,
        kpi_category: nil,
        step_number: 2
      ),
      Step.create!(
        athlete_level: nil,
        kpi_category: nil,
        step_number: 2
      )
    ])
  end

  it "renders a list of steps" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
