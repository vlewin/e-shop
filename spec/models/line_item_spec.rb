require "rails_helper"

describe LineItem do

  subject { FactoryGirl.build(:line_item) }

  it { should belong_to :order }
  it { should belong_to :product }
  it { should belong_to :cart }


  it 'calculates a max available  quantity' do
    expect(subject.max_quantity).to eq(subject.quantity + subject.product.available_quantity)
  end

  it 'calculates a total price with tax based on quantity' do
    expect(subject.total).to eq(subject.subtotal + subject.tax)
  end

  it 'calculates a total price without tax based on quantity' do
    expect(subject.subtotal).to eq(subject.product.price * subject.quantity)
  end

  it 'calculates a total tax amount based on quantity' do
    expect(subject.tax).to eq(subject.subtotal * (subject.product.vat.rate / 100.0))
  end
end
