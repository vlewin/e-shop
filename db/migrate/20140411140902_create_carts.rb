class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer  :user_id
      t.integer  :line_items_count, default: 0
      t.timestamps
    end
  end
end
