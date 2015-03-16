require "rails_helper"

describe LineItem do

  subject { FactoryGirl.build(:line_item) }

  it { should belong_to :order }
  it { should belong_to :product }
  it { should belong_to :cart }


  it 'updates a cart updated_at attribute on creation' do
    cart = FactoryGirl.create(:cart)
    updated_at = cart.updated_at

    Timecop.freeze(10.minutes.from_now) do
      cart.add_item(cart.products.first.id, 1)
      expect(cart.updated_at.to_i).to eq((updated_at + 10.minutes).to_i)
    end
  end

  it 'calculates a max available  quantity' do
    expect(subject.max_quantity).to eq(subject.quantity + subject.product.available_quantity)
  end

  it 'calculates a total price with tax based on quantity' do
    expect(subject.total).to eq(subject.subtotal + subject.tax)
  end

  it 'calculates a total price without tax based on quantity' do
    expect(subject.subtotal).to eq(subject.product.netto * subject.quantity)
  end

  it 'calculates a total tax amount based on quantity' do
    expect(subject.tax).to eq(subject.product.tax * subject.quantity)
  end
end
