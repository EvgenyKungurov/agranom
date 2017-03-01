require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:city) }
  it { should have_many(:phones).dependent(:destroy) }
  it { should accept_nested_attributes_for(:phones) }
end
