class ChangeTypeExpireDayToAds < ActiveRecord::Migration[5.0]
  def change
    change_column :ads, :expire_day, :timestamp
  end
end