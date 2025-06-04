# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'steps/edit', type: :view do
  let(:step) do
    Step.create!(
      athlete_level: nil,
      kpi_category: nil,
      step_number: 1
    )
  end

  before(:each) do
    assign(:step, step)
  end

  it 'renders the edit step form' do
    render

    assert_select 'form[action=?][method=?]', step_path(step), 'post' do
      assert_select 'input[name=?]', 'step[athlete_level_id]'

      assert_select 'input[name=?]', 'step[kpi_category_id]'

      assert_select 'input[name=?]', 'step[step_number]'
    end
  end
end
