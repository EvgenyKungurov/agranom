require 'rails_helper'

RSpec.feature 'Profiles', type: :feature do
  def sign_in(user, role = nil)
    user.add_role :admin if role == :admin
    visit '/sign_in'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  let!(:user) { FactoryGirl.create :user }
  let!(:fake_profile) { FactoryGirl.create :profile }
  let!(:profile_params) { FactoryGirl.attributes_for(:profile) }
end
