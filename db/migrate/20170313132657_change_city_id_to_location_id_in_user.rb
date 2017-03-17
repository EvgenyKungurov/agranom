class ChangeCityIdToLocationIdInUser < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :city_id, :location_id
  end
end
