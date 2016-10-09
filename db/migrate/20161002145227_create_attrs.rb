class CreateAttrs < ActiveRecord::Migration[5.0]
  def change
    create_table :attrs do |t|
      t.datetime :time
      t.integer :seat
      t.integer :status
      t.timestamps
    end
  end
end
