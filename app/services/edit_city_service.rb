# Provides nesessary vars
class EditCityService
  def initialize(profile)
    @profile = profile
  end

  def vars
    countries = Country.all
    city      = City.find(@profile.city_id).name if @profile.city_id
    region    = @profile.city.region.name if city
    [countries, city, region]
  end
end
