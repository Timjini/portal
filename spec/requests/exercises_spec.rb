# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/exercises', type: :request do # rubocop:disable Metrics/BlockLength
  # This should return the minimal set of attributes required to create a valid
  # Exercise. As you add validations to Exercise, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Exercise.create! valid_attributes
      get exercises_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      exercise = Exercise.create! valid_attributes
      get exercise_url(exercise)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_exercise_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      exercise = Exercise.create! valid_attributes
      get edit_exercise_url(exercise)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Exercise' do
        expect do
          post exercises_url, params: { exercise: valid_attributes }
        end.to change(Exercise, :count).by(1)
      end

      it 'redirects to the created exercise' do
        post exercises_url, params: { exercise: valid_attributes }
        expect(response).to redirect_to(exercise_url(Exercise.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Exercise' do
        expect do
          post exercises_url, params: { exercise: invalid_attributes }
        end.to change(Exercise, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post exercises_url, params: { exercise: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested exercise' do
        exercise = Exercise.create! valid_attributes
        patch exercise_url(exercise), params: { exercise: new_attributes }
        exercise.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the exercise' do
        exercise = Exercise.create! valid_attributes
        patch exercise_url(exercise), params: { exercise: new_attributes }
        exercise.reload
        expect(response).to redirect_to(exercise_url(exercise))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        exercise = Exercise.create! valid_attributes
        patch exercise_url(exercise), params: { exercise: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested exercise' do
      exercise = Exercise.create! valid_attributes
      expect do
        delete exercise_url(exercise)
      end.to change(Exercise, :count).by(-1)
    end

    it 'redirects to the exercises list' do
      exercise = Exercise.create! valid_attributes
      delete exercise_url(exercise)
      expect(response).to redirect_to(exercises_url)
    end
  end
end
