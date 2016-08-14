require 'rails_helper'

RSpec.describe User, type: :model do
  it 'must have email' do
    email = 'evgenii.kungurov@gmail.com'
    User.create!(email: email, password: 'test_password3000')
    expect(User.where(email: email).take.email).to eq(email)
  end
end
