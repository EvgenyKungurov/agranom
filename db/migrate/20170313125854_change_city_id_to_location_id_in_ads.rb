class ChangeCityIdToLocationIdInAds < ActiveRecord::Migration[5.0]
  def change
    rename_column :ads, :city_id, :location_id
  end
end
