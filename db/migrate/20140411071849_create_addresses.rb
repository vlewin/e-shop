class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :recipient
      t.string :city
      t.string :street
      t.string :zip_code
      t.string :phone
      t.integer :user_id
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
