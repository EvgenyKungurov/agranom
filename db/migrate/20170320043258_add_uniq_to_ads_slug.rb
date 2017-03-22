class AddUniqToAdsSlug < ActiveRecord::Migration[5.0]
  def change
    add_index :ads, :slug, unique: true
  end
end
