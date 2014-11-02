class Category < ActiveRecord::Base
  translates :title, fallbacks_for_empty_translations: true
  globalize_accessors locales: [:de, :ru], attributes: [:title]

  has_many :products
  # has_many :translations, dependent: :destroy

  validates :title, presence: true, uniqueness: true

  default_scope {
    includes(:translations)
  }

  # accepts_nested_attributes_for :products
end
