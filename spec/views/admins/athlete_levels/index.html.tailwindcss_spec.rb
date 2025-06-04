# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admins/athlete_levels/index', type: :view do # rubocop:disable Metrics/BlockLength
  before(:each) do
    assign(:athlete_levels, [
             Admins::AthleteLevel.create!(
               name: 'Name',
               position: 2,
               description: 'MyText',
               min_age: 3,
               max_age: 4,
               color: 'Color',
               active: false
             ),
             Admins::AthleteLevel.create!(
               name: 'Name',
               position: 2,
               description: 'MyText',
               min_age: 3,
               max_age: 4,
               color: 'Color',
               active: false
             )
           ])
  end

  it 'renders a list of admins/athlete_levels' do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new('Name'), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('MyText'), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Color'), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
  end
end
