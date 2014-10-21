class Shipment < ActiveRecord::Base
  validates :provider, :name, :rate,  presence: true
  validates :rate, numericality: true

  before_update :set_default
  before_create :set_default

  scope :default, -> { where(default: true) }

  def set_default
    self.class.update_all(default: false) if self.default
  end
end

