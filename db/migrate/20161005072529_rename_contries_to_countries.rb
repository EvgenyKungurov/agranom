class RenameContriesToCountries < ActiveRecord::Migration[5.0]
  def change
    rename_table :contries, :countries
  end
end
