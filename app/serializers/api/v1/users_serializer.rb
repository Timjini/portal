# frozen_string_literal: true

module Api
  module V1
    class UsersSerializer < ActiveModel::Serializer
      attributes :id, :email, :username, :auth_token, :first_name, :last_name, :parent_id, :role, :created_at,
                 :updated_at
    end
  end
end
