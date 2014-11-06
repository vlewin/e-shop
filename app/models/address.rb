class Address < ActiveRecord::Base
  belongs_to :user

  validates :recipient, :city, :street, :zip_code, :phone, :user_id,  presence: true

  enum status: { active: 0, inactive: 1 }

  scope :active, -> { where(status: statuses[:active]) }
  scope :inactive, -> { where(status: statuses[:inactive]) }

  def full_address
    "#{recipient}, #{street}, #{zip_code} #{city}"
  end
end

