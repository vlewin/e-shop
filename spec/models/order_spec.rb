require "rails_helper"

describe Order do
  subject { FactoryGirl.create(:order) }
  let(:cart) { FactoryGirl.create(:cart) }

  it { should belong_to :user }
  it { should belong_to :shipment }
  it { should belong_to :address }
  it { should belong_to :billing_address }
  it { should have_many :line_items }

  it { should validate_presence_of :shipping_address_id }
  it { should validate_presence_of :shipment_id }
  it { should validate_presence_of :pay_type }

  it {should ensure_inclusion_of(:pay_type).in_array(Order::PAYMENT_TYPES) }

  context 'order without line items' do
    subject { order = Order.new }
    it 'transfers cart items to order' do
      subject.add_line_items_from_cart(cart)

      expect(subject.line_items.size).to eq cart.line_items.size
      expect(subject.line_items.all?{|i| i.cart_id.nil?}).to eq true
    end
  end

  describe 'order with line items' do
    it 'calculates a total with taxes and shipment' do
      total = subject.line_items.to_a.sum { |item| item.total } + subject.shipment.rate
      expect(subject.total).to eq(total)
    end

    it 'calculates a price without taxes' do
      expect(subject.subtotal).to eq(5)
    end

    it 'calculates a tax amount' do
      expect(subject.taxes).to eq(1)
    end
  end

end
