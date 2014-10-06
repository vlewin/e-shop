class Address < ActiveRecord::Base
  belongs_to :user

  validates :first_name, :last_name, :city, :street, :zip, :phone, :user_id,  presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def full_address
    "#{first_name} #{first_name}, #{street}, #{zip} #{city}"
  end
end

