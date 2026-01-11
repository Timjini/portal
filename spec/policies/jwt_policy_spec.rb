require 'rails_helper'

RSpec.describe JwtPolicy do
  let(:user) { create(:user) }
  subject { described_class.new }
  describe "it handles the token life cycle" do
    it "generate jwt token" do
      policy = JwtPolicy.new(user)
      expect(policy.generate_token).to eq(user.auth_token)
    end
  end

end
