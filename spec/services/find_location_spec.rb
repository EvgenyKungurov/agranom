require 'rails_helper'

RSpec.describe 'FindLocation' do
  let!(:country) { FactoryGirl.create(:location, name: 'Россия') }
  let!(:region) do
    FactoryGirl.create(
      :location, name: 'Забайкальский край', parent_id: country.id
    )
  end
  let!(:city) do
    FactoryGirl.create(:location, name: 'Чита', parent_id: region.id)
  end

  describe FindLocation do
    it 'should return empty array without params' do
      result = FindLocation.new.call
      expect(result).to eq []
    end

    it 'should return one location without children' do
      options = { location_id: city.id.to_s }
      result = FindLocation.new(options).call
      expect(result).to eq city
    end

    it 'should return children collection' do
      options = { location_id: region.id.to_s }
      result = FindLocation.new(options).call
      children = region.children
      expect(result).to eq children
    end
  end
end
