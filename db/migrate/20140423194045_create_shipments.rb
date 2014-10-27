class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.string :provider
      t.string :title
      t.decimal :fee, precision: 8, scale: 2
      t.boolean :default, default: false
    end
  end
end
