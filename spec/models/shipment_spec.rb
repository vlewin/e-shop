require "rails_helper"

describe Shipment do
  subject { FactoryGirl.create(:shipment) }

  it 'sets default shipment' do
    expect(subject.default).to eq true
  end
end
