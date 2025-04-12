# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do # rubocop:disable Metrics/BlockLength
  let(:user) { create(:user) }
  let(:parent_user) { create(:user, role: 'parent_user') }
  let(:child_user) { create(:user, role: 'child_user', parent: parent_user) }
  let(:coach_user) { create(:user, role: 'coach') }
  let(:admin_user) { create(:user, role: 'admin') }

  # Test associations
  describe 'associations' do
    it { is_expected.to have_one(:athlete_profile).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:qr_codes).dependent(:destroy) }
    it { is_expected.to have_many(:user_checklists).dependent(:destroy) }
    it { is_expected.to have_many(:user_levels).dependent(:destroy) }
    it { is_expected.to have_many(:answers).dependent(:destroy) }
    it { is_expected.to have_many(:notifications).dependent(:destroy) }
    it { is_expected.to have_one_attached(:avatar) }
  end

  # Test validations
  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should validate_length_of(:username).is_at_least(3).is_at_most(20) }

    it { should validate_presence_of(:email) }
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }

    it { should validate_presence_of(:password).on(:create) }

    it {
      should define_enum_for(:role)
        .with_values(
          athlete: 'athlete',
          parent_user: 'parent_user',
          child_user: 'child_user',
          coach: 'coach',
          admin: 'admin'
        )
        .backed_by_column_of_type(:string)
    }
  end

  # testing scopes
  describe 'scopes' do
    before do
      create(:user, role: 'coach')
      create(:user, role: 'parent_user')
      create(:user, role: 'child_user')
    end

    it '.coaches returns only coaches' do
      expect(User.coaches.count).to eq(1)
      expect(User.coaches.first.role).to eq('coach')
    end

    it '.by_role filters by role' do
      expect(User.by_role('coach').count).to eq(1)
      expect(User.by_role(nil).count).to eq(3)
    end
  end

  # Test instance methods
  describe 'instance methods' do # rubocop:disable Metrics/BlockLength
    describe '#parent_user?' do
      it 'returns true for parent user' do
        expect(parent_user.parent_user?).to be true
      end

      it 'returns false for non-parent user' do
        expect(user.parent_user?).to be false
      end
    end

    describe '#child_users' do
      before { create_list(:user, 2, role: 'child_user', parent_id: parent_user.id) }

      it 'returns children users for parent' do
        expect(parent_user.child_users.count).to eq(2)
      end
    end

    describe '#full_name' do
      let(:named_user) { create(:user, first_name: 'John', last_name: 'Doe') }

      it 'returns capitalized full name' do
        expect(named_user.full_name).to eq('John Doe')
      end

      it 'returns "Unknown" when names are missing' do
        user.update(first_name: nil, last_name: nil)
        expect(user.full_name).to eq('Unknown')
      end
    end

    # describe '#avatar_thumbnail' do
    #   context 'when avatar is attached' do
    #     before do
    #       user.avatar.attach(
    #         io: Rails.root.join('spec/fixtures/sample_athlete.png').open,
    #         filename: 'sample_athlete.png',
    #         content_type: 'image/png'
    #       )
    #     end

    #     it 'returns the avatar' do
    #       expect(user.avatar_thumbnail).to eq(user.avatar)
    #     end
    #   end

    #   context 'when avatar is not attached' do
    #     it 'returns default image path' do
    #       expect(user.avatar_thumbnail).to eq('user.png')
    #     end
    #   end
    # end

    describe '#current_level' do
      context 'with completed user levels' do
        before do
          create_list(:user_level, 4, user: user, status: 'completed')
          create_list(:user_level, 6, user: user, status: 'completed')
        end

        it 'returns correct level based on completed levels' do
          expect(user.current_level).to eq('Intermediate')
        end
      end

      context 'with no completed levels' do
        it 'returns Beginner' do
          expect(user.current_level).to eq('Beginner')
        end
      end
    end

    # describe '#generate_jwt' do
    #   it 'returns a JWT token' do
    #     token = user.generate_jwt
    #     expect(token).to be_a(String)
    #     expect(token.split('.').count).to eq(3) # JWT has 3 parts
    #   end
    # end
  end

  # Test athlete profile delegation
  describe 'athlete profile delegation' do
    let(:user_with_profile) { create(:user, :with_athlete_profile) }

    it 'delegates methods to athlete profile' do
      expect(user_with_profile.athlete_profile_data_height).to eq(user_with_profile.athlete_profile.height)
      expect(user_with_profile.athlete_profile_data_weight).to eq(user_with_profile.athlete_profile.weight)
    end

    it 'returns defaults when no profile exists' do
      expect(user.athlete_profile_data_height).to eq('---')
      expect(user.athlete_profile_data_weight).to eq('---')
    end
  end

  # Test callbacks
  describe 'callbacks' do
    describe 'before_create' do
      it 'assigns a unique color' do
        new_user = build(:user)
        expect(new_user.color).to be_nil
        new_user.save
        expect(new_user.color).to match(/#[0-9a-f]{6}/)
      end
    end

    describe 'before_save' do
      it 'normalizes username to lowercase' do
        user = create(:user, username: 'TestUser')
        expect(user.username).to eq('testuser')
      end
    end
  end
end
