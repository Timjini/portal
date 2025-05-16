# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AthleteLevelsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/athlete_levels').to route_to('athlete_levels#index')
    end

    it 'routes to #new' do
      expect(get: '/athlete_levels/new').to route_to('athlete_levels#new')
    end

    it 'routes to #show' do
      expect(get: '/athlete_levels/1').to route_to('athlete_levels#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/athlete_levels/1/edit').to route_to('athlete_levels#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/athlete_levels').to route_to('athlete_levels#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/athlete_levels/1').to route_to('athlete_levels#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/athlete_levels/1').to route_to('athlete_levels#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/athlete_levels/1').to route_to('athlete_levels#destroy', id: '1')
    end
  end
end
