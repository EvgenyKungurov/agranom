class AddExpireDayToAd < ActiveRecord::Migration[5.0]
  def change
    add_column :ads, :expire_day, :date
  end
end
