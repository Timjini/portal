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

RSpec.describe '/admin/athlete_levels', type: :request do # rubocop:disable Metrics/BlockLength
  # This should return the minimal set of attributes required to create a valid
  # Admin::AthleteLevel. As you add validations to Admin::AthleteLevel, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Admin::AthleteLevel.create! valid_attributes
      get admin_athlete_levels_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      athlete_level = Admin::AthleteLevel.create! valid_attributes
      get admin_athlete_level_url(athlete_level)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_admin_athlete_level_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      athlete_level = Admin::AthleteLevel.create! valid_attributes
      get edit_admin_athlete_level_url(athlete_level)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Admin::AthleteLevel' do
        expect do
          post admin_athlete_levels_url, params: { admin_athlete_level: valid_attributes }
        end.to change(Admin::AthleteLevel, :count).by(1)
      end

      it 'redirects to the created admin_athlete_level' do
        post admin_athlete_levels_url, params: { admin_athlete_level: valid_attributes }
        expect(response).to redirect_to(admin_athlete_level_url(Admin::AthleteLevel.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Admin::AthleteLevel' do
        expect do
          post admin_athlete_levels_url, params: { admin_athlete_level: invalid_attributes }
        end.to change(Admin::AthleteLevel, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post admin_athlete_levels_url, params: { admin_athlete_level: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested admin_athlete_level' do
        athlete_level = Admin::AthleteLevel.create! valid_attributes
        patch admin_athlete_level_url(athlete_level), params: { admin_athlete_level: new_attributes }
        athlete_level.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the admin_athlete_level' do
        athlete_level = Admin::AthleteLevel.create! valid_attributes
        patch admin_athlete_level_url(athlete_level), params: { admin_athlete_level: new_attributes }
        athlete_level.reload
        expect(response).to redirect_to(admin_athlete_level_url(athlete_level))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        athlete_level = Admin::AthleteLevel.create! valid_attributes
        patch admin_athlete_level_url(athlete_level), params: { admin_athlete_level: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested admin_athlete_level' do
      athlete_level = Admin::AthleteLevel.create! valid_attributes
      expect do
        delete admin_athlete_level_url(athlete_level)
      end.to change(Admin::AthleteLevel, :count).by(-1)
    end

    it 'redirects to the admin_athlete_levels list' do
      athlete_level = Admin::AthleteLevel.create! valid_attributes
      delete admin_athlete_level_url(athlete_level)
      expect(response).to redirect_to(admin_athlete_levels_url)
    end
  end
end
