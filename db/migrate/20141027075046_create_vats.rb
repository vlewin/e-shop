class CreateVats < ActiveRecord::Migration
  def change
    create_table :vats do |t|
      t.string   :title
      t.integer  :rate
    end
  end
end
