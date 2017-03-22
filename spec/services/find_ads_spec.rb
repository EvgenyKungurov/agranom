require 'rails_helper'

RSpec.describe FindAds do
  let!(:category) { FactoryGirl.create(:category) }
  let!(:subcategory) do
    FactoryGirl.create(
      :category, name: 'Для Комбайнов', parent_id: category.id
    )
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
  let!(:user) { FactoryGirl.create(:user, location_id: city.id) }
  let!(:user_ad) do
    FactoryGirl.create(
      :ad, user_id: user.id, category_id: category.id,
           location_id: city.id
    )
  end
  let!(:user_ad2) do
    FactoryGirl.create(
      :ad, user_id: user.id, category_id: subcategory.id,
           location_id: country.id
    )
  end

  describe FindAds do
    it 'should return empty array without params' do
      result = FindAds.new.call
      expect(result).to eq []
    end

    # it 'should return ad with all params' do
    #   options = { location_id: city.id.to_s, category_id: category.id.to_s }
    #   result = FindAds.new(options).call
    #   ads = Ad.find_by(options)
    #   expect(result).to eq ads
    # end

    # it 'should return children collection' do
    #   options = { location_id: region.id.to_s }
    #   result = FindAds.new(options).call
    #   children = region.children
    #   expect(result).to eq children
    # end
  end
end
