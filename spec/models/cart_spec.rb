require "rails_helper"

describe Cart do
  subject! { FactoryGirl.create(:cart) }
  let(:cart_product) { subject.products.first }
  let(:empty_cart) { FactoryGirl.create(:empty_cart) }
  let(:product) { FactoryGirl.create(:product) }
  let(:shipment) { FactoryGirl.create(:shipment) }


  it { should have_many :line_items }

  describe '.purge' do
    it 'destroyes staled carts' do
      expect(Cart.count).to eq 1

      Timecop.freeze(3.hours.from_now) do
        subject.class.purge()
      end

      expect(Cart.count).to eq 0
    end

    it 'keeps active carts' do
      expect(Cart.count).to eq 1

      subject.class.purge()

      expect(Cart.count).to eq 1
    end
  end

  context 'empty cart' do
    describe '#add_item' do
      it 'adds new item' do
        empty_cart.add_item(product.id, 2)

        expect(empty_cart.line_items.count).to eq 1
        expect(empty_cart.line_items.first.quantity).to eq 2
      end

      it 'sums a quantity' do
        empty_cart.add_item(product.id, 1)
        empty_cart.add_item(product.id, 1)

        line_items = empty_cart.line_items.reload

        expect(line_items.count).to eq 1
        expect(line_items.first.quantity).to eq 2
      end

      it 'increases a product reserved counter' do
        expect(product.reserved_count).to eq 0

        empty_cart.add_item(product.id, 2)

        expect(product.reload.reserved_count).to eq 2
      end
    end

    describe '#empty?' do
      it 'checks if cart is empty' do
        expect(empty_cart.empty?).to be true
      end
    end
  end

  describe '#update_item' do
    let(:line_item) { subject.line_items.first }
    it 'updates a quantity' do
      expect(line_item.quantity).to eq 1
      subject.update_item(line_item.id, 2)
      expect(line_item.reload.quantity).to eq 2
    end

    it 'increases a product reserved counter' do
      expect(product.reserved_count).to eq 0

      empty_cart.add_item(product.id, 2)

      expect(product.reload.reserved_count).to eq 2
    end

    it 'preserves the max of available product quantity' do
      expect(line_item.quantity).to eq 1
      subject.update_item(line_item.id, 3)
      expect(line_item.reload.quantity).to eq 1
    end
  end

  describe '#count' do
    it 'counts the quantity of all products' do
      expect(subject.count).to eq(subject.line_items.sum(:quantity))
    end
  end

  describe '#subtotal' do
    it 'calculates a price with taxes' do
      subtotal = subject.line_items.to_a.sum { |item| item.total }
      expect(subject.subtotal).to eq(subtotal)
    end
  end

  describe '#total' do
    it 'calculates a price with taxes and shipping costs' do
      quantity = subject.line_items.to_a.sum(&:quantity)
      expect(subject.count).to eq(quantity)
    end
  end

  describe '#taxes' do
    it 'calculates a tax amount' do
      taxes = subject.line_items.to_a.sum { |item| item.tax }
      expect(subject.taxes).to eq(taxes)
    end
  end
end



