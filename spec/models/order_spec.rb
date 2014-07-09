require "rails_helper"

describe Order do
  subject { FactoryGirl.build(:order) }
  let(:cart) { FactoryGirl.build(:cart) }

  it { should belong_to :address }
  it { should belong_to :shipment }
  it { should have_one :user }
  it { should have_many :line_items }

  it { should validate_presence_of :address_id }
  it { should validate_presence_of :shipment_id }
  it { should validate_presence_of :pay_type }

  it {should ensure_inclusion_of(:pay_type).in_array(Order::PAYMENT_TYPES) }

  it 'transfers cart items to order' do
    subject.line_items.destroy_all

    expect_any_instance_of(Product).to receive(:decrease_quantity).exactly(cart.line_items.count).times
    expect_any_instance_of(LineItem).to receive(:save!).exactly(cart.line_items.count).times

    subject.add_line_items_from_cart(cart)

    expect(subject.line_items.count).to eq cart.line_items.count

  end

  it 'calculates a total with taxes' do
    expect(subject.total).to eq(6)
  end

  it 'calculates a price without taxes' do
    expect(subject.subtotal).to eq(5)
  end

  it 'calculates a tax amount' do
    expect(subject.taxes).to eq(1)
  end

end
