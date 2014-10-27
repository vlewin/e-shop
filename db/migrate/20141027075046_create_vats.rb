class CreateVats < ActiveRecord::Migration
  def change
    create_table :vats do |t|
      t.string   :title
      t.decimal   :rate, precision: 8, scale: 2
    end
  end
end
