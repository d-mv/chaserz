class CreateRaces < ActiveRecord::Migration[5.2]
  def change
    create_table :races do |t|
      t.string :title
      t.time :start_date
      t.string :category
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
