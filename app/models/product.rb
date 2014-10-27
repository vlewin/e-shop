class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  belongs_to :category, counter_cache: true
  belongs_to :vat
  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  # validates :name, length: { minimum: 4 }

  def decrease_quantity(amount=1)
    amount = ((quantity-amount) < 0) ? 0 : quantity-amount
    self.update_attribute(:quantity, amount)
  end

  def available_quantity
    self.quantity - reserved_quantity
  end

  def reserved_quantity
    self.line_items.where(order_id: nil).sum(:quantity)
  end

  def sold_quantity
    self.line_items.where.not(order_id: nil).sum(:quantity)
  end

  def out_of_stock?
    self.quantity.zero? || reserved_quantity >= self.quantity
  end

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
