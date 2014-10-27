class Payment < ActiveRecord::Base
  validates :title, presence: true
end
