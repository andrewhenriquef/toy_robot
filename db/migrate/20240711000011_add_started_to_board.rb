class AddStartedToBoard < ActiveRecord::Migration[7.1]
  def change
    add_column :boards, :started, :boolean, default: false, null: false
  end
end
