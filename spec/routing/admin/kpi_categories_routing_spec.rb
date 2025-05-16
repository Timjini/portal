# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::KpiCategoriesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin/kpi_categories').to route_to('admin/kpi_categories#index')
    end

    it 'routes to #new' do
      expect(get: '/admin/kpi_categories/new').to route_to('admin/kpi_categories#new')
    end

    it 'routes to #show' do
      expect(get: '/admin/kpi_categories/1').to route_to('admin/kpi_categories#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/admin/kpi_categories/1/edit').to route_to('admin/kpi_categories#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/admin/kpi_categories').to route_to('admin/kpi_categories#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/admin/kpi_categories/1').to route_to('admin/kpi_categories#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/admin/kpi_categories/1').to route_to('admin/kpi_categories#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/kpi_categories/1').to route_to('admin/kpi_categories#destroy', id: '1')
    end
  end
end
