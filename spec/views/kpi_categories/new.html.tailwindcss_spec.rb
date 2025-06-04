# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'kpi_categories/new', type: :view do
  before(:each) do
    assign(:kpi_category, KpiCategory.new(
                            name: 'MyString',
                            description: 'MyText'
                          ))
  end

  it 'renders new kpi_category form' do
    render

    assert_select 'form[action=?][method=?]', kpi_categories_path, 'post' do
      assert_select 'input[name=?]', 'kpi_category[name]'

      assert_select 'textarea[name=?]', 'kpi_category[description]'
    end
  end
end
