# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'steps/new', type: :view do
  before(:each) do
    assign(:step, Step.new(
                    athlete_level: nil,
                    kpi_category: nil,
                    step_number: 1
                  ))
  end

  it 'renders new step form' do
    render

    assert_select 'form[action=?][method=?]', steps_path, 'post' do
      assert_select 'input[name=?]', 'step[athlete_level_id]'

      assert_select 'input[name=?]', 'step[kpi_category_id]'

      assert_select 'input[name=?]', 'step[step_number]'
    end
  end
end
