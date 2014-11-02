class Payment < ActiveRecord::Base
  translates :title
  globalize_accessors locales: [:de, :ru], attributes: [:title]

  validates :title, presence: true

  default_scope {
    includes(:translations)
  }
end
