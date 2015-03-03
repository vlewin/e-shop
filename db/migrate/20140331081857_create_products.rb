class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string    :title
      t.string    :ean
      t.text      :description
      t.decimal   :price, precision: 8, scale: 2
      t.string    :image
      t.integer   :quantity, default: 0
      t.integer   :reserved_count, default: 0
      t.integer   :sold_count, default: 0
      t.integer   :category_id
      t.integer   :vat_id
      t.timestamps
    end
  end
end
