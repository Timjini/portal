# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admin/kpi_categories/new', type: :view do
  before(:each) do
    assign(:admin_kpi_category, Admin::KpiCategory.new(
                                  name: 'MyString',
                                  description: 'MyText'
                                ))
  end

  it 'renders new admin_kpi_category form' do
    render

    assert_select 'form[action=?][method=?]', admin_kpi_categories_path, 'post' do
      assert_select 'input[name=?]', 'admin_kpi_category[name]'

      assert_select 'textarea[name=?]', 'admin_kpi_category[description]'
    end
  end
end
