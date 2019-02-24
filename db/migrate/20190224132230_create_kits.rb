class CreateKits < ActiveRecord::Migration[5.2]
  def change
    create_table :kits do |t|
      t.string :name
      t.text :description
      t.string :photo
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
