require 'rails_helper'

RSpec.describe Country, type: :model do
  subject { FactoryGirl.build(:country) }

  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least 2 }
  it { should validate_presence_of(:short_name) }
  it { should validate_length_of(:short_name).is_at_least 2 }

  it { should have_many(:regions) }

  describe 'before_save' do
    it 'should invoke #name_capitalize' do
      expect(subject).to receive(:name_capitalize)
      subject.save!
    end

    it 'should invoke #short_name_upcase' do
      expect(subject).to receive(:short_name_upcase)
      subject.save!
    end
  end
end
