class AddMissingSearchIndexes < ActiveRecord::Migration
  def change
    add_index :carts, :updated_at
    add_index :addresses, :status
    add_index :product_translations, :title
    add_index :category_translations, :title
    add_index :payment_translations, :title
    add_index :shipment_translations, :title
  end
end
