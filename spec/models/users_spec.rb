require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:city) { FactoryGirl.create :city }
  subject { FactoryGirl.build(:user, city_id: city.id) }

  it { should have_one(:profile).dependent(:destroy) }
  it { should have_many(:ads).dependent(:destroy) }
  it { should have_many(:photos).dependent(:destroy) }
  it { should belong_to(:city) }
  it { should validate_presence_of(:city_id) }

  describe 'after_create' do
    it 'should invoke #create_user_profile method' do
      expect(subject).to receive(:create_user_profile)
      subject.save!
    end

    it 'should #create_user_profile method return new related profile' do
      subject.save!
      expect(Profile.where(user_id: subject.id).take.user_id).to eq subject.id
    end
  end

  describe 'rolify' do
    it 'should respond to #has_role? method' do
      subject.save!
      expect(subject).to respond_to(:has_role?)
    end
  end
end
