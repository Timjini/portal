# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'athlete_levels/edit', type: :view do
  let(:athlete_level) do
    AthleteLevel.create!(
      name: 'MyString',
      position: 1,
      description: 'MyText',
      min_age: 1,
      max_age: 1,
      color: 'MyString',
      active: false
    )
  end

  before(:each) do
    assign(:athlete_level, athlete_level)
  end

  it 'renders the edit athlete_level form' do
    render

    assert_select 'form[action=?][method=?]', athlete_level_path(athlete_level), 'post' do
      assert_select 'input[name=?]', 'athlete_level[name]'

      assert_select 'input[name=?]', 'athlete_level[position]'

      assert_select 'textarea[name=?]', 'athlete_level[description]'

      assert_select 'input[name=?]', 'athlete_level[min_age]'

      assert_select 'input[name=?]', 'athlete_level[max_age]'

      assert_select 'input[name=?]', 'athlete_level[color]'

      assert_select 'input[name=?]', 'athlete_level[active]'
    end
  end
end
