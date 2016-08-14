require 'rails_helper'

RSpec.describe 'should be able sign in', type: :request do
  it 'should be load sign_in' do
    get '/sign_in'
    expect(response).to be_success
    expect(response).to have_http_status(200)
  end

  it 'displays the user email after successful login' do
    User.create!(email: 'user@example.com', password: 'secret')
    visit '/sign_in'
    fill_in 'user[email]', with: 'user@example.com'
    fill_in 'user[password]', with: 'secret'
    click_button 'Log in'
    expect(page).to have_selector('#user_email', text: 'user@example.com')
  end
end
