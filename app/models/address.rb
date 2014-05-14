class Address < ActiveRecord::Base
  belongs_to :user
  has_many :orders

  validates :country, :city, :street, :zip, :phone, :user_id,  presence: true

  def full_address
    "#{user.name}, #{street}, #{zip} #{city}"
  end
end
