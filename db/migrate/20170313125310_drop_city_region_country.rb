class DropCityRegionCountry < ActiveRecord::Migration[5.0]
  def change
    drop_table :cities
    drop_table :regions
    drop_table :countries
  end
end
