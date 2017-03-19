class AddStatusToAds < ActiveRecord::Migration[5.0]
  def change
    add_column :ads, :status, :integer
  end
end
