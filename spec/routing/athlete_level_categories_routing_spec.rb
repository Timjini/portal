# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AthleteLevelCategoriesController, type: :routing do # rubocop:disable Metrics/BlockLength
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/athlete_level_categories').to route_to('athlete_level_categories#index')
    end

    it 'routes to #new' do
      expect(get: '/athlete_level_categories/new').to route_to('athlete_level_categories#new')
    end

    it 'routes to #show' do
      expect(get: '/athlete_level_categories/1').to route_to('athlete_level_categories#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/athlete_level_categories/1/edit').to route_to('athlete_level_categories#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/athlete_level_categories').to route_to('athlete_level_categories#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/athlete_level_categories/1').to route_to('athlete_level_categories#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/athlete_level_categories/1').to route_to('athlete_level_categories#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/athlete_level_categories/1').to route_to('athlete_level_categories#destroy', id: '1')
    end
  end
end
