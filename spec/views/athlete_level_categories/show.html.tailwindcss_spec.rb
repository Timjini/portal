# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'athlete_level_categories/show', type: :view do
  before(:each) do
    assign(:athlete_level_category, AthleteLevelCategory.create!(
                                      athlete_level: nil,
                                      kpi_category: nil
                                    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
