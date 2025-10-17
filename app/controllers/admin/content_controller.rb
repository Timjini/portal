# frozen_string_literal: true

module Admin
  class ContentController < ApplicationController
    authorize_resource class: false

    def index; end
  end
end
