class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :products, :category_id
    add_index :products, :vat_id
    add_index :orders, :user_id
    add_index :orders, :shipment_id
    add_index :orders, :payment_id
    add_index :orders, :shipping_address_id
    add_index :orders, :billing_address_id
    add_index :carts, :shipment_id
    add_index :addresses, :user_id
    add_index :users, [:invited_by_id, :invited_by_type]
  end
end
