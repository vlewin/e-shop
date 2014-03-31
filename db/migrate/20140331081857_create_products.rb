class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :part_number
      t.string :title
      t.string :name
      t.string :description
      t.string :amount
      t.decimal :price, :precision => 10, :scale => 2
      t.decimal :vat, :precision => 10, :scale => 2
      t.timestamps
    end
  end
end
