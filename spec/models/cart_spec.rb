require "rails_helper"

describe Cart do
  subject { FactoryGirl.build(:cart) }
  let(:empty_cart) { FactoryGirl.create(:empty_cart) }
  let(:product) { FactoryGirl.create(:product) }
  let(:shipment) { FactoryGirl.create(:shipment) }

  it { should have_many :line_items }


  it 'adds product to cart' do
    expect(subject.add_product(product.id, 1))
  end

  it 'checks if cart is empty' do
    expect(empty_cart.empty?).to be true
  end

  it 'counts the quantity of all products' do
    expect(subject.count).to eq(subject.line_items.sum(:quantity))
  end

  it 'calculates a price with taxes and shipping costs' do
    total = subject.line_items.to_a.sum { |item| item.total } + shipment.rate
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

  # def add_product(product_id, quantity=1)
  #   current_item = line_items.find_by(product_id: product_id)

  #   if current_item
  #     if current_item.quantity
  #       current_item.quantity += quantity.to_i.zero? ? 1 : quantity.to_i
  #     else
  #       current_item.quantity = quantity
  #     end
  #   else
  #     current_item = line_items.build(product_id: product_id, quantity: quantity)
  #     current_item.price = current_item.product.price
  #   end
  #   current_item
  # end


