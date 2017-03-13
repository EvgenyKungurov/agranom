require 'rails_helper'

RSpec.describe AdsController, type: :future do
  let!(:category) { FactoryGirl.create :category }
  let!(:country) { FactoryGirl.create :country }
  let!(:region) { FactoryGirl.create(:region, country_id: country.id) }
  let!(:city) { FactoryGirl.create(:city, region_id: region.id) }
  let!(:user) { FactoryGirl.create(:user, city_id: city.id) }
  let!(:user_ad) do
    FactoryGirl.create(
      :ad, user_id: user.id, category_id: category.id, city_id: city.id
    )
  end

  describe 'GET /ads/' do
    context 'with location_id' do
      it 'should be return last records' do
        visit "/ads/#{city.name})"
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Войти'
        expect(response).to have_http_status(200)
      end
    end

    context 'with location_id and category_id' do
      it 'should be available' do
        get ads_path('chita', 'selhoztehnika')
        expect(response).to have_http_status(200)
      end
    end
  end
end
