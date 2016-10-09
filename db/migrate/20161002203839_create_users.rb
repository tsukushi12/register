class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :addr
      t.string :url
      t.integer :status
      t.integer :attr_id

      t.timestamps
    end
  end
end
