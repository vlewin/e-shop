class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string   :title
      t.text     :description
      t.integer  :products_count, default: 0
      t.timestamps
    end
  end
end
