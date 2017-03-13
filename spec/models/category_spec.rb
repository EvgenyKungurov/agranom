require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { FactoryGirl.build(:category) }

  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least 3 }

  it { should have_many(:ads) }
end
