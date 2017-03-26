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

  def category_with_children(category)
    Category.find_by(id: category)&.self_and_descendants&.map(&:id)
  end

  def location_with_children(location)
    Location.find_by(id: location)&.self_and_descendants&.map(&:id)
  end

  describe FindAds do
    it 'should return empty array without params' do
      result = FindAds.new.call
      expect(result).to eq []
    end

    it 'should return ads with location && category params' do
      result =
        FindAds.new(location_id: location_with_children(city.id), category_id: category_with_children(category.id)).call
      ads =
        Ad.where(
          location_id: location_with_children(city.id),
          category_id: category_with_children(category.id)
        ).active
      expect(result).to match_array ads
    end

    it 'should return ads with location param' do
      result =
        FindAds.new(location_id: location_with_children(city.id)).call
      ads =
        Ad.where(location_id: location_with_children(city.id)).active
      expect(result).to match_array ads
    end

    it 'should return redirect to ads with no location param' do
      result =
        FindAds.new(category_id: category_with_children(category.id)).call
      expect(result).to eq []
    end

    it 'should return ads with search && location params' do
      result =
        FindAds.new(
          location_id: location_with_children(city.id),
          search: 'комбайн'
        ).call
      ads =
        Ad.search('комбайн').where(location_id: city.id).active
      expect(result).to match_array ads
    end
  end
end
