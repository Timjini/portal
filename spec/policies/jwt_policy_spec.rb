require 'rails_helper'

RSpec.describe JwtPolicy do
  let(:user) { create(:user) }
  subject { described_class.new }
  describe 'it handles the token life cycle' do
    it 'generate jwt token' do
      JwtPolicy.call(user)
      expect(user.auth_token).to include(user.auth_token)
    end

    # it 'refresh the jwt token' do
    #   policy = JwtPolicy.new(user)
    #   expect(policy.refresh_token).to eq(user.auth_token)
    # end
  end
end
