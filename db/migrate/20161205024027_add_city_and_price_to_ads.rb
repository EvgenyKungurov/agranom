class AddCityAndPriceToAds < ActiveRecord::Migration[5.0]
  def change
    add_column :ads, :price,   :integer
    add_column :ads, :city_id, :integer
  end
end
