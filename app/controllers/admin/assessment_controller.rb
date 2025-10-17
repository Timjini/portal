# frozen_string_literal: true

module Admin
  class AssessmentController < ApplicationController
    authorize_resource class: false

    def index; end
  end
end
