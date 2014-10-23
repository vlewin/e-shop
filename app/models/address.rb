class Address < ActiveRecord::Base
  belongs_to :user

  validates :recipient, :city, :street, :zip_code, :phone, :user_id,  presence: true

  def full_address
    "#{recipient}, #{street}, #{zip_code} #{city}"
  end
end

