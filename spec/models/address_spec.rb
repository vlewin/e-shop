require "rails_helper"

describe Address do
  subject { FactoryGirl.build(:address) }
  let(:order_address) { FactoryGirl.build(:order).address }

  it { should belong_to :user }

  it { should validate_presence_of :recipient }
  it { should validate_presence_of :city }
  it { should validate_presence_of :street }
  it { should validate_presence_of :zip_code }
  it { should validate_presence_of :phone }
  it { should validate_presence_of :user_id }

  it 'returns a full address' do
    expect(subject.full_address).to eq("#{subject.recipient}, #{subject.street}, #{subject.zip_code} #{subject.city}")
  end

  context 'in use' do
    it '#in_use?' do
      expect(order_address.in_use?).to be true
    end

    describe '.ensure_not_referenced_by_any_order' do
      it 'ensure that there are no orders referencing this address' do
        expect(order_address.send(:ensure_not_referenced_by_any_order)).to eq false
        expect(order_address.errors).not_to be_empty
      end
    end
  end

  context 'not in use' do
    it '#in_use?' do
      expect(subject.in_use?).to be false
    end

    describe '.ensure_not_referenced_by_any_order' do
      it 'ensure that there are no orders referencing this address' do
        expect(subject.send(:ensure_not_referenced_by_any_order)).to eq true
        expect(subject.errors).to be_empty
      end
    end
  end
end
