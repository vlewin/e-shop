class Vat < ActiveRecord::Base
  validates :title, :rate, presence: true
end
