# frozen_string_literal: true

module Api
  module V2
    class BaseController < ApplicationController
      def deep_underscore_params!(hash)
        hash.deep_transform_keys! { |k| k.to_s.underscore }
      end
    end
  end
end
