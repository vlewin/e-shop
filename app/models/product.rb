class Product < ActiveRecord::Base
  belongs_to :category

  validates :name, presence: true

  accepts_nested_attributes_for :category
end
