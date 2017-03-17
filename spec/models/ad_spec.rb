require 'rails_helper'

RSpec.describe Ad, type: :model do
  let!(:country) { FactoryGirl.create(:location, name: 'Россия') }
  let!(:region) do
    FactoryGirl.create(
      :location, name: 'Забайкальский край', parent_id: country.id
    )
  end
  let!(:city) do
    FactoryGirl.create(:location, name: 'Чита', parent_id: region.id)
  end
  let!(:user) { FactoryGirl.create(:user, location_id: city.id) }
  let!(:category) { FactoryGirl.create :category }
  subject { FactoryGirl.build(:ad, user_id: user.id, category_id: category.id) }

  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_least 6 }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:category_id) }
  it { should validate_presence_of(:location_id) }
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

    it 'should invoke #save_slug_attribute method' do
      expect(subject).to receive(:save_slug_attribute)
      subject.save!
    end

    it 'should #save_slug_attribute method return translite name' do
      subject.save!
      expect(subject.slug)
        .to eq Translit.convert(subject.title).downcase.split.join('-')
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
