class AddInfoToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :name,  :string
    add_column :profiles, :city,  :integer
    add_column :profiles, :phone, :integer
  end
end
