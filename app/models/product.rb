class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  translates :title, :description, fallbacks_for_empty_translations: true
  globalize_accessors locales: [:de, :ru], attributes: [:title, :description]

  belongs_to :category, counter_cache: true
  belongs_to :vat
  has_many :line_items
  has_many :orders, through: :line_items

  validates :title, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true

  before_destroy :ensure_not_referenced_by_any_line_item

  default_scope {
    includes(:translations).with_translations.uniq
  }

  class << self
    def next_id
      (Product.maximum(:id).to_i + 1).to_s.rjust(2, '0')
    end

    def first_letters
      query = 'SELECT DISTINCT(substr(title,1,1)) AS first_letter FROM product_translations'
      Product.find_by_sql(query).map(&:first_letter).sort
    end
  end

  def decrease_quantity(amount=1)
    amount = ((quantity-amount) < 0) ? 0 : quantity-amount
    update_attribute(:quantity, amount)
  end

  def available_quantity
    quantity - reserved_count
  end

  def sold_quantity
    line_items.where.not(order_id: nil).sum(:quantity)
  end

  def out_of_stock?
    quantity.zero? || reserved_count == quantity
  end

  def netto
    (price - tax).round(2)
  end

  def tax
    (price - (price / tax_factor)).round(2)
  end

  def tax_factor
    vat.rate.to_f/100+1
  end

  private

  # Ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:product, 'is referenced by a line item')
      return false
    end
  end
end
