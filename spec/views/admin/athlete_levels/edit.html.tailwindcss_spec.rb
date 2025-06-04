# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admin/athlete_levels/edit', type: :view do
  let(:admin_athlete_level) do
    Admin::AthleteLevel.create!(
      name: 'MyString'
    )
  end

  before(:each) do
    assign(:admin_athlete_level, admin_athlete_level)
  end

  it 'renders the edit admin_athlete_level form' do
    render

    assert_select 'form[action=?][method=?]', admin_athlete_level_path(admin_athlete_level), 'post' do
      assert_select 'input[name=?]', 'admin_athlete_level[name]'
    end
  end
end
