require 'rails_helper'

RSpec.describe 'should be able sign in', type: :request do
  let!(:country) { FactoryGirl.create(:location, name: 'Россия') }
  let!(:region) do
    FactoryGirl.create(
      :location, name: 'Забайкальский край', parent_id: country.id
    )
  end
  let!(:city) do
    FactoryGirl.create(:location, name: 'Чита', parent_id: region.id)
  end
  let(:user) { FactoryGirl.create(:user, location_id: city.id) }

  def sign_in(user)
    visit sign_in_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Войти'
  end

  it 'should be load sign_in' do
    get sign_in_path
    expect(response).to be_success
    expect(response).to have_http_status(200)
  end

  it 'displays the user email after successful login' do
    sign_in(user)
    expect(page).to have_selector('#user_email', text: user.email)
  end
end
