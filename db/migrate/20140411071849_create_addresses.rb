class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :city
      t.string :street
      t.string :zip
      t.string :phone
      t.string :user_id
      t.timestamps
    end
  end
end
