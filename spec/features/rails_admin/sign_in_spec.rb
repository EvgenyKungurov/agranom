require 'rails_helper'

RSpec.feature 'Rails admin', type: :feature do
  def sign_in(user, role = nil)
    user.add_role :admin if role == :admin
    visit '/sign_in'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Войти'
  end

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
  let!(:article) { FactoryGirl.create :article }
  let!(:article_params) { FactoryGirl.attributes_for(:article) }

  describe 'GET #rails_admin' do
    it 'should not be available for users' do
      sign_in(user)
      visit rails_admin_path
      expect(current_path).to eq root_path
    end

    it 'should not be available for anonymous' do
      visit new_article_path
      expect(current_path).to eq new_user_session_path
    end

    it 'can only admin' do
      sign_in(user, :admin)
      visit rails_admin_path
      expect(current_path).to eq rails_admin_path
    end
  end
end
