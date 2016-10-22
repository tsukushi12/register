class AddColumnToAttrs < ActiveRecord::Migration[5.0]
  def change
    add_column :attrs, :authenticated_at, :datetime
  end
end
