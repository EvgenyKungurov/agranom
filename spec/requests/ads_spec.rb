require 'rails_helper'

RSpec.describe AdsController, type: :request do
  let!(:category) { FactoryGirl.create :category }
  let!(:country) { FactoryGirl.create(:location, name: 'Россия') }
  let!(:region) do
    FactoryGirl.create(
      :location, name: 'Забайкальский край', parent_id: country.id
    )
  end
  let!(:city) do
    FactoryGirl.create(:location, name: 'Чита', parent_id: region.id)
  end
  let!(:user) { FactoryGirl.create(:user, location_id: city.id) }
  let!(:user_ad) do
    FactoryGirl.create(
      :ad, user_id: user.id, category_id: category.id, location_id: city.id
    )
  end

  describe 'GET /ads/' do
    context 'with parent_id' do
      it 'should be available' do
        get ads_path('chita')
        expect(response).to have_http_status(200)
      end
    end

    context 'with parent_id and category_id' do
      it 'should be available' do
        get ads_path('chita', 'selhoztehnika')
        expect(response).to have_http_status(200)
      end
    end
  end
end
