require 'rails_helper'

describe GuestUser do
  it 'should #profile method return empty' do
    guest = GuestUser.new.profile
    expect(guest).to eq Profile.none
  end

  it 'should #email method return guest email' do
    guest = GuestUser.new.email
    expect(guest).to eq 'guest@example.com'
  end
end
