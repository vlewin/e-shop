class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  belongs_to :category, counter_cache: true
  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :name, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :name, uniqueness: true
  validates :name, length: { minimum: 4 }

  def decrease_quantity(amount=1)
    self.update_attribute(:quantity, (self.quantity-amount)) unless self.quantity.zero? || (self.quantity-amount) < 0
  end

  def total_quantity
    self.quantity + self.sold_quantity
  end

  def available_quantity
    diff = self.quantity - reserved_quantity
    diff > 0 ? diff : 0
  end

  def reserved_quantity
    self.line_items.where('order_id is NULL').sum(:quantity)
  end

  def sold_quantity
    self.line_items.where('order_id is not NULL').sum(:quantity)
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
