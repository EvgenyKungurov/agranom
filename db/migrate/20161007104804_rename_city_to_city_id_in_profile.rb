class RenameCityToCityIdInProfile < ActiveRecord::Migration[5.0]
  def change
    rename_column :profiles, :city, :city_id
  end
end
