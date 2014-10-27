class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :title
    end
  end
end
