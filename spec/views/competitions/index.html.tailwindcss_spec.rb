# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'competitions/index', type: :view do
  before(:each) do
    assign(:competitions, [
             Competition.create!,
             Competition.create!
           ])
  end

  it 'renders a list of competitions' do
    render
    'div>p'
  end
end
