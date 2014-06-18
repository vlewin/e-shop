require "rails_helper"

describe User do
  subject { FactoryGirl.build(:user) }

  it 'sets default user role to user' do
    expect(subject.user?).to be true
  end

  it 'returns first address per default' do
    expect(subject.default_address).to equal(subject.addresses.first)
  end
end
