class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string   :name
      t.string   :article_number
      t.text     :description
      t.integer  :quantity,    :default => 0
      t.string   :cover
      t.integer  :category_id
      t.decimal  :price, :precision => 10, :scale => 2
      t.decimal  :tax, :precision => 10, :scale => 2
      t.timestamps
    end
  end
end
