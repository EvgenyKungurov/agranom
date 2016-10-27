class CreatePhones < ActiveRecord::Migration[5.0]
  def change
    create_table :phones do |t|
      t.text :number
      t.references :profile, foreign_key: true, index: true

      t.timestamps
    end
  end
end
