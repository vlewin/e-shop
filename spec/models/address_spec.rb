require "rails_helper"

describe Address do
  subject { FactoryGirl.build(:address) }

  it { should belong_to :user }

  it { should validate_presence_of :recipient }
  it { should validate_presence_of :city }
  it { should validate_presence_of :street }
  it { should validate_presence_of :zip_code }
  it { should validate_presence_of :phone }
  it { should validate_presence_of :user_id }

  it 'returns a post address' do
    expect(subject.full_address).to eq("#{subject.recipient}, #{subject.street}, #{subject.zip_code} #{subject.city}")
  end
end
