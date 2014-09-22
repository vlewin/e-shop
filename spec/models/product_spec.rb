require "rails_helper"

describe Product do
  subject { FactoryGirl.build(:product, quantity: 2) }

  it { should belong_to :category }
  it { should have_many :line_items }
  it { should have_many :orders }

  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0.01) }
  it { should validate_uniqueness_of :name }
  it { should ensure_length_of(:name).is_at_least(4) }


  describe '.decrease_quantity' do
    it 'decreases quantity by 1 per default' do
      subject.decrease_quantity
      expect(subject.quantity).to be 1
    end

    it 'decreases quantity by passed on amount' do
      subject.decrease_quantity(2)
      expect(subject.quantity).to be 0
    end
  end

  describe '.total_quantity' do
    it 'calculates total quantity' do
      expect(subject.total_quantity).to be 2
    end
  end

  describe '.available_quantity' do
    it 'calculates available quantity' do
      expect(subject.available_quantity).to be 2
    end

    it 'returns 0 if all products sold or reserved' do
      expect(subject).to receive(:reserved_quantity).and_return 2
      expect(subject.available_quantity).to be 0
    end
  end

  describe '.reserved_quantity' do
    it 'calculates reserved quantity' do
      expect(subject.reserved_quantity).to be 0
    end
  end

  describe '.sold_quantity' do
    it 'calculates sold quantity' do
      expect(subject.sold_quantity).to be 0
    end
  end

  describe '.out_of_stock?' do
    it 'returns true if quantity 0' do
      subject.quantity = 0
      expect(subject.out_of_stock?).to be true
    end

    it 'returns false if quantity > 0' do
      expect(subject.out_of_stock?).to be false
    end
  end

  describe '.ensure_not_referenced_by_any_line_item' do
    it 'ensure that there are no line items referencing this product' do
      expect(subject.send(:ensure_not_referenced_by_any_line_item)).to be true
    end

    it 'adds an error if product is referenced by a line item' do
      expect(subject).to receive(:line_items).and_return [1]
      expect(subject.send(:ensure_not_referenced_by_any_line_item)).to be false
      expect(subject.errors).not_to be_empty
    end
  end

end
