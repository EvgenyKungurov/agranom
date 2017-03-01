require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryGirl.build :user }

  it { should have_one(:profile).dependent(:destroy) }
  it { should have_many(:ads).dependent(:destroy) }
  it { should have_many(:photos).dependent(:destroy) }

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
