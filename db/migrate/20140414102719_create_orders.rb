class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :shipping_address_id
      t.integer :billing_address_id, default: nil
      t.integer :shipment_id
      t.integer :user_id
      t.integer :payment_id
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
