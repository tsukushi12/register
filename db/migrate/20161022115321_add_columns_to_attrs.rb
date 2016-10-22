class AddColumnsToAttrs < ActiveRecord::Migration[5.0]
  def change
    add_column :attrs, :attended, :boolean, default: false, null: false
    add_column :attrs, :mail1, :boolean, default: false, null: false
    add_column :attrs, :mail2, :boolean, default: false, null: false
  end
end
