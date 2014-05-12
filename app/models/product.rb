class Product < ActiveRecord::Base
  belongs_to :category
  # has_many :line_items

  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :name, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :name, uniqueness: true
  # validates :image_url, allow_blank: true, format: {
  #   with:    %r{\.(gif|jpg|png)\Z}i,
  #   message: 'must be a URL for GIF, JPG or PNG image.'
  # }

  validates :name, length: { minimum: 4 }

  private

  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:product, 'is referenced by a line item')
      return false
    end
  end
end
