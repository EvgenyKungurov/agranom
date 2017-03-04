require 'rails_helper'

RSpec.describe 'FindCity' do
  let!(:country) { FactoryGirl.create :country }
  let!(:region) { FactoryGirl.create(:region, country_id: country.id) }
  let!(:city) { FactoryGirl.create(:city, region_id: region.id) }

  describe FindCity do
    it 'should return empty array without params' do
      result = FindCity.new.call
      expect(result).to eq []
    end

    it 'should return regions collection' do
      options = { get_id: country.id.to_s, type_of_request: 'select_region' }
      result = FindCity.new(options).call.first
      expect(result).to be_an_instance_of Region
    end

    it 'should return cities collection' do
      options = { get_id: region.id.to_s, type_of_request: 'select_city' }
      result = FindCity.new(options).call.first
      expect(result).to be_an_instance_of City
    end
  end
end
