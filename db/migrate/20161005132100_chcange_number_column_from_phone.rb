class ChcangeNumberColumnFromPhone < ActiveRecord::Migration[5.0]
  def change
    change_column :phones, :number, :string, length: 30
  end
end
