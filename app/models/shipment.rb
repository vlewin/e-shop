class Shipment < ActiveRecord::Base
  translates :title
  globalize_accessors locales: [:de, :ru], attributes: [:title]

  validates :provider, :title, :fee,  presence: true
  validates :fee, numericality: true

  before_update :set_default
  before_create :set_default

  default_scope {
    includes(:translations).uniq
  }

  def self.default
    where(default: true).first
  end

  def set_default
    if self.default && self.class.count > 1
      self.class.update_all(default: false)
    end
  end
end

