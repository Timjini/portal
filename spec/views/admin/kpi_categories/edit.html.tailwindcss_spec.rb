# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admin/kpi_categories/edit', type: :view do
  let(:admin_kpi_category) do
    KpiCategory.create!(
      name: 'MyString',
      description: 'MyText'
    )
  end

  before(:each) do
    assign(:admin_kpi_category, admin_kpi_category)
  end

  it 'renders the edit admin_kpi_category form' do
    render

    assert_select 'form[action=?][method=?]', admin_kpi_category_path(admin_kpi_category), 'post' do
      assert_select 'input[name=?]', 'admin_kpi_category[name]'

      assert_select 'textarea[name=?]', 'admin_kpi_category[description]'
    end
  end
end
