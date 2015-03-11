class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer  :line_items_count, default: 0
      t.integer :shipment_id
      t.timestamps
    end
  end
end
