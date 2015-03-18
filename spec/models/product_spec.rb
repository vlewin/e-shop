require "rails_helper"

describe Product do
  subject { FactoryGirl.build(:product, price: 10, quantity: 2) }

  it { should belong_to :category }
  it { should belong_to :vat }
  it { should have_many :line_items }
  it { should have_many :orders }

  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0.01) }
  it { should validate_uniqueness_of :title }

  describe '.next_id' do
    context 'empty database' do
      it 'returns the next unused product ID' do
        expect(described_class.next_id).to eq '01'
      end
    end

    context 'not empty database' do
      it 'returns the next unused product ID' do
        FactoryGirl.create(:product)
        expect(described_class.next_id).to eq '02'
      end
    end
  end

  describe '.first_letters' do
    context 'English' do
      it 'returns the first letters of product title translations' do
        I18n.locale = :en
        ['Aa', 'Bb', 'Yy', 'Zz'].each{|title| FactoryGirl.create(:product, title: title) }

        expect(described_class.first_letters).to match_array(['A', 'B', 'Y', 'Z'])
      end
    end

    context 'German' do
      it 'returns the first letters of product title translations' do
        I18n.locale = :de
        ['Ää', 'Öö', 'Üü'].each{|title| FactoryGirl.create(:product, title: title) }

        expect(described_class.first_letters).to match_array(['Ä', 'Ö', 'Ü'])
      end
    end

    context 'Russian' do
      it 'returns the first letters of product title translations' do
        I18n.locale = :ru
        ['Аа', 'Бб', 'Юю', 'Яя'].each{|title| FactoryGirl.create(:product, title: title) }

        expect(described_class.first_letters).to match_array(['А', 'Б', 'Ю', 'Я'])
      end
    end
  end

  describe '#decrease_quantity' do
    it 'decreases quantity by 1 per default' do
      expect{subject.decrease_quantity}.to change{subject.quantity}.by(-1)
    end

    it 'decreases quantity by passed on amount' do
      expect{subject.decrease_quantity(2)}.to change{subject.quantity}.from(2).to(0)
    end

    it 'sets quantity to zero if passed amount is greater than quantity' do
      expect{subject.decrease_quantity(20)}.to change{subject.quantity}.from(2).to(0)
    end
  end

  describe '#available_quantity' do
    it 'calculates available quantity' do
      expect(subject.available_quantity).to eq subject.quantity
    end

    it 'returns 0 if all products sold or reserved' do
      subject.update(reserved_count: subject.quantity)
      expect(subject.available_quantity).to eq 0
    end
  end

  describe '#sold_quantity' do
    it 'calculates sold quantity' do
      expect(subject.sold_quantity).to eq 0
    end
  end

  describe '#out_of_stock?' do
    it 'returns true if quantity 0' do
      subject.quantity = 0
      expect(subject.out_of_stock?).to eq true
    end

    it 'returns false if quantity > 0' do
      expect(subject.out_of_stock?).to eq false
    end
  end

  describe '#netto' do
    it 'returns netto price' do
      expect(subject.netto).to eq 8.40
    end
  end

  describe '#tax' do
    it 'returns tax value' do
      expect(subject.tax).to eq 1.60
    end
  end

  describe '#tax_factor' do
    it 'calculates tax factor (standard VAT rate)' do
      expect(subject.tax_factor).to eq 1.19
    end

    it 'calculates tax factor (non-standard VAT rate)' do
      subject.vat = FactoryGirl.create(:vat, rate: 4)
      expect(subject.tax_factor).to eq 1.04
    end
  end

  describe '#ensure_not_referenced_by_any_line_item' do
    it 'ensure that there are no line items referencing this product' do
      expect(subject.send(:ensure_not_referenced_by_any_line_item)).to eq true
    end

    it 'adds an error if product is referenced by a line item' do
      expect(subject).to receive(:line_items).and_return [1]
      expect(subject.send(:ensure_not_referenced_by_any_line_item)).to eq false
      expect(subject.errors).not_to be_empty
    end
  end

end
