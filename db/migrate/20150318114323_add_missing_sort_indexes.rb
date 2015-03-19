class AddMissingSortIndexes < ActiveRecord::Migration
  def change
    add_index :products, :price
    add_index :products, :created_at
    add_index :products, :updated_at
  end
end
