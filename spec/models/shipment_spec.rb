require "rails_helper"

describe Shipment do
  subject { FactoryGirl.build(:shipment) }

  it 'sets default shipment' do
    expect(subject.class).to receive(:default).and_return []
    expect(subject.class).to receive(:update_all).with(default: false)
    expect(subject).to receive(:update_attributes).with(default: true)
    subject.save
  end
end
