require 'rails_helper'

RSpec.describe Location, type: :model do
  subject { FactoryGirl.build :location }

  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least 2 }
  it { should have_many(:ads) }

  describe 'before_save' do
    it 'should invoke #name_capitalize' do
      expect(subject).to receive(:name_capitalize)
      subject.save!
    end

    it 'should #normalize_friendly_id return russian translite' do
      subject.save!
      slug = subject.name.to_slug.normalize(transliterations: :russian).to_s
      expect(subject.slug).to eq slug
    end

    it 'should invoke #update_slug' do
      expect(subject).to receive(:update_slug)
      subject.save!
    end
  end

  describe 'after_create' do
    it 'should invoke #parent_count_increase' do
      expect(subject).to receive(:parent_count_increase)
      subject.save!
    end

    it 'should #parent_count_increase +1' do
      subject.save!
      count = subject.children_count
      subject.children.create!(name: 'Забайкальский край')
      expect(subject.children_count).to eq count + 1
    end
  end

  describe 'after_destroy' do
    it 'should invoke #parent_count_decrease' do
      expect(subject).to receive(:parent_count_decrease)
      subject.destroy!
    end

    it 'should #parent_count_decrease -1' do
      subject.save!
      count = subject.children_count
      subject.children.create!(name: 'Забайкальский край')
      subject.children.destroy_all
      expect(Location.find(subject.id).children_count).to eq count
    end
  end
end
