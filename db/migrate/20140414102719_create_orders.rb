class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :address_id
      t.integer :shipment_id
      t.string :pay_type
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
