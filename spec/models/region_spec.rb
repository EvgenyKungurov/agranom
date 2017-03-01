require 'rails_helper'

RSpec.describe Region, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least 2 }
  it { should belong_to(:country) }
  it { should have_many(:cities) }
end
