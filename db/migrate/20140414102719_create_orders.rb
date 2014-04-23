class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :address_id
      t.integer :delivery_service_id
      t.string :pay_type

      t.timestamps
    end
  end
end
