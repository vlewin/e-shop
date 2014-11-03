require "rails_helper"

describe Category do
  subject { FactoryGirl.build(:category) }

  it { should have_many :products }
  it { should validate_presence_of :title }
  it { should validate_uniqueness_of :title }
end

