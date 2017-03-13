class AddSlugToAds < ActiveRecord::Migration[5.0]
  def change
    add_column :ads, :slug, :string, index: true
  end
end
