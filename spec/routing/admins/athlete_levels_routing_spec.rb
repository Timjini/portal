# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admins::AthleteLevelsController, type: :routing do # rubocop:disable Metrics/BlockLength
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admins/athlete_levels').to route_to('admins/athlete_levels#index')
    end

    it 'routes to #new' do
      expect(get: '/admins/athlete_levels/new').to route_to('admins/athlete_levels#new')
    end

    it 'routes to #show' do
      expect(get: '/admins/athlete_levels/1').to route_to('admins/athlete_levels#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/admins/athlete_levels/1/edit').to route_to('admins/athlete_levels#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/admins/athlete_levels').to route_to('admins/athlete_levels#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/admins/athlete_levels/1').to route_to('admins/athlete_levels#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/admins/athlete_levels/1').to route_to('admins/athlete_levels#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/admins/athlete_levels/1').to route_to('admins/athlete_levels#destroy', id: '1')
    end
  end
end
