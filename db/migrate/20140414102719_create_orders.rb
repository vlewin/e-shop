class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :shipment_id
      t.integer :billing_address_id
      t.integer :shipping_address_id
      t.integer :status, default: 0
      t.string :pay_type
      t.timestamps
    end
  end
end
