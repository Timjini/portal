class Api::V1::UsersSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :auth_token, :first_name, :last_name , :created_at, :parent_id, :role
end
