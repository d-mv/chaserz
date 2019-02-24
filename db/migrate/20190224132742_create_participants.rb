class CreateParticipants < ActiveRecord::Migration[5.2]
  def change
    create_table :participants do |t|
      t.references :user, foreign_key: true
      t.references :race, foreign_key: true
      t.integer :duration
      t.integer :points
      t.string :status

      t.timestamps
    end
  end
end
