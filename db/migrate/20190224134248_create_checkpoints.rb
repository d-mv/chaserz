class CreateCheckpoints < ActiveRecord::Migration[5.2]
  def change
    create_table :checkpoints do |t|
      t.references :race, foreign_key: true
      t.float :lat
      t.float :lon
      t.integer :position
      t.string :location

      t.timestamps
    end
  end
end
