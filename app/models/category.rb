class Category < ActiveRecord::Base
  translates :title, fallbacks_for_empty_translations: true
  globalize_accessors locales: [:de, :ru], attributes: [:title]

  has_many :products

  validates :title, presence: true, uniqueness: true

  default_scope {
    includes(:translations)
  }
end
