# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::AthleteLevelsController, type: :routing do # rubocop:disable Metrics/BlockLength
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin/athlete_levels').to route_to('admin/athlete_levels#index')
    end

    it 'routes to #new' do
      expect(get: '/admin/athlete_levels/new').to route_to('admin/athlete_levels#new')
    end

    it 'routes to #show' do
      expect(get: '/admin/athlete_levels/1').to route_to('admin/athlete_levels#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/admin/athlete_levels/1/edit').to route_to('admin/athlete_levels#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/admin/athlete_levels').to route_to('admin/athlete_levels#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/admin/athlete_levels/1').to route_to('admin/athlete_levels#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/admin/athlete_levels/1').to route_to('admin/athlete_levels#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/athlete_levels/1').to route_to('admin/athlete_levels#destroy', id: '1')
    end
  end
end
