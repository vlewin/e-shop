require "rails_helper"

describe User do
  subject { FactoryGirl.build(:user) }

  it 'sets default user role to user' do
    expect(subject.user?).to be true
  end
end
