# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'athlete_level_categories/edit', type: :view do
  let(:athlete_level_category) do
    AthleteLevelCategory.create!(
      athlete_level: nil,
      kpi_category: nil
    )
  end

  before(:each) do
    assign(:athlete_level_category, athlete_level_category)
  end

  it 'renders the edit athlete_level_category form' do
    render

    assert_select 'form[action=?][method=?]', athlete_level_category_path(athlete_level_category), 'post' do
      assert_select 'input[name=?]', 'athlete_level_category[athlete_level_id]'

      assert_select 'input[name=?]', 'athlete_level_category[kpi_category_id]'
    end
  end
end
