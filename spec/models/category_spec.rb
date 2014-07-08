require "rails_helper"

describe Category do
  subject { FactoryGirl.build(:category) }

  it { should have_many :products }
  it { should validate_presence_of :name }
  it { should accept_nested_attributes_for :products }
end

