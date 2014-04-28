class Shipment < ActiveRecord::Base
  after_create :set_default

  scope :default, -> { where(default: true) }

  def set_default
    self.update_attributes(default: true) #if user.default_address.blank?
  end
end
