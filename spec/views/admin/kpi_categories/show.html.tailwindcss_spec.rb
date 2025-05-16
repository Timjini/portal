# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admin/kpi_categories/show', type: :view do
  before(:each) do
    assign(:admin_kpi_category, Admin::KpiCategory.create!(
                                  name: 'Name',
                                  description: 'MyText'
                                ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
