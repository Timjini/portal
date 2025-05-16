# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admins/athlete_levels/show', type: :view do
  before(:each) do
    assign(:athlete_level, Admins::AthleteLevel.create!(
                             name: 'Name',
                             position: 2,
                             description: 'MyText',
                             min_age: 3,
                             max_age: 4,
                             color: 'Color',
                             active: false
                           ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Color/)
    expect(rendered).to match(/false/)
  end
end
