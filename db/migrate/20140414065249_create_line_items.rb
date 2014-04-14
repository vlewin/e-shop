class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :product, index: true
      t.references :order, index: true
      t.belongs_to :cart, index: true
      t.integer :quantity, default: 1
      t.decimal   :price, precision: 8, scale: 2
      t.timestamps
    end
  end
end
