class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string    :name
      t.string    :article_number
      t.text      :description
      t.integer   :quantity, default: 0
      t.string    :image
      t.integer   :category_id
      t.decimal   :price, precision: 8, scale: 2
      t.decimal   :tax, precision: 8, scale: 2
      t.timestamps
    end
  end
end
