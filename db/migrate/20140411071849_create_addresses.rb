class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :country, default: 'Germany'
      t.string :city
      t.string :street
      t.string :zip
      t.string :phone
      t.string :type, default: 'ShippingAddress'
      t.integer :user_id
      t.timestamps
    end
  end
end
