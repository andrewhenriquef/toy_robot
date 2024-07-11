class AddPlacedToRobot < ActiveRecord::Migration[7.1]
  def change
    add_column :robots, :placed, :boolean, default: false, null: false
  end
end
