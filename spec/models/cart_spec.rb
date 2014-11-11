require "rails_helper"

describe Cart do
  subject { FactoryGirl.build(:cart) }
  let(:empty_cart) { FactoryGirl.create(:empty_cart) }
  let(:product) { FactoryGirl.create(:product) }
  let(:shipment) { FactoryGirl.create(:shipment) }

  it { should have_many :line_items }

  it 'adds product to cart' do
    item = subject.add_product(product.id, 3)
    expect(item.cart_id).to eq subject.id
    expect(item.quantity).to eq 3
  end

  it 'checks if cart is empty' do
    expect(empty_cart.empty?).to be true
  end

  it 'counts the quantity of all products' do
    expect(subject.count).to eq(subject.line_items.sum(:quantity))
  end

  it 'calculates a price with taxes and shipping costs' do
    total = subject.line_items.to_a.sum { |item| item.total } + shipment.fee
    expect(subject.total).to eq(total)
  end

  it 'calculates a price without taxes' do
    subtotal = subject.line_items.to_a.sum { |item| item.subtotal }
    expect(subject.subtotal).to eq(subtotal)
  end

  it 'calculates a tax amount' do
    taxes = subject.line_items.to_a.sum { |item| item.tax }
    expect(subject.taxes).to eq(taxes)
  end
end



