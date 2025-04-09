# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AthleteProfile, type: :model do # rubocop:disable Metrics/BlockLength
  let(:user) { create(:user) }
  let(:valid_attributes) do
    {
      first_name: 'Kim',
      last_name: 'Sting',
      dob: 20.years.ago.to_date,
      address: '123 Main St',
      city: 'New York',
      user: user
    }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(described_class.new(valid_attributes)).to be_valid
    end

    it 'requires first_name' do
      profile = described_class.new(valid_attributes.merge(first_name: nil))
      expect(profile).not_to be_valid
      expect(profile.errors[:first_name]).to include("can't be blank")
    end

    it 'requires last_name' do
      profile = described_class.new(valid_attributes.merge(last_name: nil))
      expect(profile).not_to be_valid
      expect(profile.errors[:last_name]).to include("can't be blank")
    end

    it 'enforces uniqueness of first_name scoped to last_name (case insensitive)' do
      create(:athlete_profile, first_name: 'Kim', last_name: 'Sting')
      profile = described_class.new(valid_attributes)
      expect(profile).not_to be_valid
      expect(profile.errors[:first_name]).to include('has already been taken')
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
      expect(association.options[:optional]).to be true
    end

    it 'has one attached image' do
      expect(described_class.new.image).to be_an_instance_of(ActiveStorage::Attached::One)
    end
  end

  describe 'enums' do
    it 'defines level enum' do
      expect(described_class.levels).to eq(
        'development' => 0,
        'intermediate' => 1,
        'advanced' => 2
      )
    end
  end

  describe 'callbacks' do
    it 'sets default level to development before validation on create' do
      profile = described_class.create(valid_attributes.merge(level: nil))
      expect(profile.level).to eq('development')
    end
  end

  describe '#image_thumbnail' do
    let(:profile) { create(:athlete_profile, valid_attributes) }

    context 'when image is attached' do
      before do
        profile.image.attach(
          io: Rails.root.join('spec/fixtures/sample_athlete.png').open,
          filename: 'sample_athlete.jpg',
          content_type: 'image/jpeg'
        )
      end

      it 'returns the attached image' do
        expect(profile.image_thumbnail).to eq(profile.image)
      end
    end

    context 'when image is not attached' do
      it 'returns default image URL' do
        expect(profile.image_thumbnail).to eq('https://pub-bc4cae30cb704275a2d82ae56b32c9b6.r2.dev/cfs/user.png')
      end
    end
  end

  describe '#age' do
    let(:profile) { described_class.new(valid_attributes) }

    it 'returns correct age' do
      profile.dob = 25.years.ago.to_date
      expect(profile.age).to eq(25)
    end

    it 'returns nil when dob is blank' do
      profile.dob = nil
      expect(profile.age).to be_nil
    end

    it 'handles birthday not yet occurred this year' do
      profile.dob = Date.new(1990, Time.zone.today.month + 1, 1) # Next month
      expect(profile.age).to eq(Time.zone.today.year - 1990 - 1)
    end
  end

  describe '#athlete_category' do
    let(:profile) { described_class.new(valid_attributes) }

    it 'returns "Child" for ages 0-12' do
      profile.dob = 10.years.ago.to_date
      expect(profile.athlete_category).to eq('Child')
    end

    it 'returns "Junior" for ages 13-18' do
      profile.dob = 15.years.ago.to_date
      expect(profile.athlete_category).to eq('Junior')
    end

    it 'returns "Senior" for ages 19-60' do
      profile.dob = 25.years.ago.to_date
      expect(profile.athlete_category).to eq('Senior')
    end

    it 'returns nil when age cannot be calculated' do
      profile.dob = nil
      expect(profile.athlete_category).to be_nil
    end
  end

  describe '#full_name' do
    it 'combines first and last name' do
      profile = described_class.new(first_name: 'John', last_name: 'Doe')
      expect(profile.full_name).to eq('John Doe')
    end

    it 'handles nil values' do
      profile = described_class.new(first_name: nil, last_name: 'Doe')
      expect(profile.full_name).to eq('Doe')
    end
  end

  describe '#full_name=' do
    it 'splits full name into first and last names' do
      profile = described_class.new
      profile.full_name = 'John Michael Doe'
      expect(profile.first_name).to eq('John')
      expect(profile.last_name).to eq('Michael Doe')
    end

    it 'handles nil values' do
      profile = described_class.new
      profile.full_name = nil
      expect(profile.first_name).to be_nil
      expect(profile.last_name).to be_nil
    end
  end

  describe '#full_address' do
    it 'combines address and city' do
      profile = described_class.new(address: '123 Main St', city: 'New York')
      expect(profile.full_address).to eq('123 Main St, New York')
    end

    it 'handles nil values' do
      profile = described_class.new(address: nil, city: 'New York')
      expect(profile.full_address).to eq('New York')
    end
  end

  describe '#check_lists' do
    it 'returns user checklists when user exists' do
      user = create(:user)
      checklist = create(:user_checklist, user: user)
      profile = create(:athlete_profile, user: user)
      expect(profile.check_lists).to eq([checklist])
    end

    it 'returns empty array when user is nil' do
      profile = described_class.new
      expect(profile.check_lists).to eq([])
    end
  end

  describe '#user_illnesses' do
    let(:user) { create(:user) }
    let(:profile) { create(:athlete_profile, user: user) }
    let!(:question1) { create(:question, id: 1, illness_tag: 'Osgood Schlatter Disease') }
    let!(:question2) { create(:question, id: 2) }
    let!(:question3) { create(:question, id: 3, illness_tag: 'High blood pressure') }

    it 'returns array of illness names for positive answers' do
      create(:answer, :positive, user: user, question: question1)
      create(:answer, :positive, user: user, question: question3)
      expect(profile.user_illnesses).to contain_exactly(
        'Osgood Schlatter Disease',
        'High blood pressure'
      )
    end

    it 'returns empty array when no positive answers' do
      create(:answer, user: user, question: question1, content: 'No')
      expect(profile.user_illnesses).to eq([])
    end

    it 'returns empty array when user is nil' do
      profile = described_class.new
      expect(profile.user_illnesses).to eq([])
    end
  end
end
