class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.references :user, foreign_key: true
      t.references :race, foreign_key: true
      t.float :lat
      t.float :lon

      t.timestamps
    end
  end
end
