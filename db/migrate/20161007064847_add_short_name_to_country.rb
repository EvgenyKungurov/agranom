class AddShortNameToCountry < ActiveRecord::Migration[5.0]
  def change
    add_column :countries, :short_name, :string, lenght: 5
  end
end
