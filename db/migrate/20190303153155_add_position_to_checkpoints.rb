class AddPositionToCheckpoints < ActiveRecord::Migration[5.2]
  def change
    add_column :checkpoints, :position, :integer
  end
end
