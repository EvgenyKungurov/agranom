require 'rails_helper'

RSpec.describe Ad, type: :model do
  let!(:city) { FactoryGirl.create :city }
  let!(:user) { FactoryGirl.create(:user, city_id: city.id) }
  let!(:category) { FactoryGirl.create :category }
  subject { FactoryGirl.build(:ad, user_id: user.id, category_id: category.id) }

  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_least 6 }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:category_id) }
  it { should validate_presence_of(:city_id) }
  it { should validate_presence_of(:price) }

  it { should belong_to(:user) }
  it { should belong_to(:category) }
  it { should have_many(:photos).dependent(:destroy) }

  describe 'before_save' do
    it 'should invoke #set_expire_day method' do
      expect(subject).to receive(:set_expire_day)
      subject.save!
    end

    it 'should #set_expire_day method return +1 month' do
      require_date = Time.zone.now
      allow(Time.zone).to receive(:now) { require_date }
      subject.save!
      expect(subject.expire_day).to eq require_date + 1.month
    end
  end

  describe 'after_save' do
    it 'should invoke #pg_search_rebuild method' do
      expect(subject).to receive(:pg_search_rebuild)
      subject.save!
    end
  end

  describe 'scope methods' do
    it 'should have #active method' do
      expect(Ad).to respond_to(:active)
    end

    it 'should #active method return actual records' do
      subject.save!
      expect(Ad.active.first).to eq subject
    end

    it 'should have #not_active method' do
      expect(Ad).to respond_to(:not_active)
    end

    it 'should #not_active method return archive records' do
      require_date = Time.zone.now
      allow(Time.zone).to receive(:now) { require_date - 1.month - 1.day }
      subject.save!
      allow(Time.zone).to receive(:now).and_call_original
      expect(Ad.not_active.first).to eq subject
    end
  end
end
