class Shipment < ActiveRecord::Base
  # after_create :set_default

  # scope :default, -> { where(default: true) }

  # def set_default
  #   if self.class.default.blank?
  #     self.class.update_all(default: false)
  #     self.update_attributes(default: true)
  #   end
  # end
end
