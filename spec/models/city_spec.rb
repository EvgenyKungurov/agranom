require 'rails_helper'

RSpec.describe City, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least 2 }

  it { should belong_to(:region) }
  it { should have_one(:country).through(:region) }
end
