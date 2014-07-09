require "rails_helper"

describe LineItem do

  subject { FactoryGirl.build(:line_item) }

  it { should belong_to :order }
  it { should belong_to :product }
  it { should belong_to :cart }

  it 'calculates a total price with taxes based on quantity' do
    expect(subject.total).to eq(6)
  end

  it 'calculates a total price without taxes based on quantity' do
    expect(subject.subtotal).to eq(5)
  end

  it 'calculates a total tax amount based on quantity' do
    expect(subject.tax).to eq(1)
  end
end
