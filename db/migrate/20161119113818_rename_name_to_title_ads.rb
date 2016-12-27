class RenameNameToTitleAds < ActiveRecord::Migration[5.0]
  def change
    rename_column :ads, :name, :title
  end
end
