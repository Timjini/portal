# frozen_string_literal: true

module Api
  module V1
    class UsersSerializer < ActiveModel::Serializer
      attributes :id, :email, :username, :auth_token, :first_name, :last_name, :created_at, :parent_id, :role
    end
  end
end
