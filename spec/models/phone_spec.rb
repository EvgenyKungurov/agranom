require 'rails_helper'

RSpec.describe Phone, type: :model do
  it { should validate_presence_of(:number) }
  it { should validate_length_of(:number).is_at_least 2 }
end
