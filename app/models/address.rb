class Address < ActiveRecord::Base
  belongs_to :user
  has_many :orders

  validates :country, :city, :street, :zip, :phone, :user_id,  presence: true

  # after_initialize :set_default, :if => :new_record?
  after_create :set_default
  after_destroy :set_default

  scope :default, -> { where(default: true) }

  def set_default
    self.update_attributes(default: true) if user.default_address.blank?
  end

  def full_address
    "#{street} #{city}, #{zip} #{country}"
  end
end
