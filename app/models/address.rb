class Address < ActiveRecord::Base
  belongs_to :user
  has_many :orders

  def full_address
    "#{street} #{city}, #{zip} #{country}"
  end
end
