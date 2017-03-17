require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:country) { FactoryGirl.create(:location, name: 'Россия') }
  let!(:region) do
    FactoryGirl.create(
      :location, name: 'Забайкальский край', parent_id: country.id
    )
  end
  let!(:city) do
    FactoryGirl.create(:location, name: 'Чита', parent_id: region.id)
  end
  subject { FactoryGirl.build(:user, location_id: city.id) }

  it { should have_one(:profile).dependent(:destroy) }
  it { should have_many(:ads).dependent(:destroy) }
  it { should have_many(:photos).dependent(:destroy) }
  it { should belong_to(:location) }
  it { should validate_presence_of(:location_id) }

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
