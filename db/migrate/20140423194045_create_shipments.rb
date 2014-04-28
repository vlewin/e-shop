class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.string :provider
      t.string :name
      t.decimal :rate
      t.boolean :default, default: false

      t.timestamps
    end
  end
end
