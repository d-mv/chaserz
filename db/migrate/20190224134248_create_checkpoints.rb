class CreateCheckpoints < ActiveRecord::Migration[5.2]
  def change
    create_table :checkpoints do |t|
      t.references :race, foreign_key: true
      t.float :latitude
      t.float :longitude
      t.integer :position
      t.string :location

      t.timestamps
    end
  end
end
