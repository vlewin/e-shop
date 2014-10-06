class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :street
      t.string :zip
      t.string :phone
      t.integer :user_id
      t.timestamps
    end
  end
end
