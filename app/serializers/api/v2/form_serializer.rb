# frozen_string_literal: true

module Api
  module V2
    class FormSerializer < ActiveModel::Serializer
      attributes :id, :email, :title, :name, :phone, :status, :subject, :message, :created_at
    end
  end
end
