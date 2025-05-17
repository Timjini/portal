# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StepExercisesController, type: :routing do # rubocop:disable Metrics/BlockLength
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/step_exercises').to route_to('step_exercises#index')
    end

    it 'routes to #new' do
      expect(get: '/step_exercises/new').to route_to('step_exercises#new')
    end

    it 'routes to #show' do
      expect(get: '/step_exercises/1').to route_to('step_exercises#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/step_exercises/1/edit').to route_to('step_exercises#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/step_exercises').to route_to('step_exercises#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/step_exercises/1').to route_to('step_exercises#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/step_exercises/1').to route_to('step_exercises#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/step_exercises/1').to route_to('step_exercises#destroy', id: '1')
    end
  end
end
