class AddColumnAuthenticatedAddrToAttr < ActiveRecord::Migration[5.0]
  def change
    add_column :attrs, :authenticated_addr, :string
  end
end
