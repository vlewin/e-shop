class TranslateShipments < ActiveRecord::Migration
  def self.up
    Shipment.create_translation_table!({
      title: :string
    }, {
      migrate_data: true
    })
  end

  def self.down
    Shipment.drop_translation_table! migrate_data: true
  end
end
