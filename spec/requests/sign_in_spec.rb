require 'rails_helper'

RSpec.describe 'should be able sign in', type: :request do
  let(:user) { FactoryGirl.create :user }

  def sign_in(user)
    visit sign_in_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  # def sign_in(user)
  #   user = { 'user[email]' => user.email, 'user[password]' => user.password }
  #   post new_user_session_path, params: user
  #   follow_redirect!
  # end

  it 'should be load sign_in' do
    get sign_in_path
    expect(response).to be_success
    expect(response).to have_http_status(200)
  end

  it 'displays the user email after successful login' do
    sign_in(user)
    expect(page).to have_selector('#user_email', text: user.email)
    # assert_select '#user_email', text: user.email
  end
end
