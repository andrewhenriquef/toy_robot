class CreateRobots < ActiveRecord::Migration[7.1]
  def change
    create_table :robots do |t|
      t.integer :axis_x
      t.integer :axis_y
      t.string :face
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end
  end
end
