# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'competitions/edit', type: :view do
  let(:competition) do
    Competition.create!
  end

  before(:each) do
    assign(:competition, competition)
  end

  it 'renders the edit competition form' do
    render

    assert_select 'form[action=?][method=?]', competition_path(competition), 'post' do # rubocop:disable Lint/EmptyBlock
    end
  end
end
