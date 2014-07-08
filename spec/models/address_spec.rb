require "rails_helper"

describe Address do
  subject { FactoryGirl.build(:address) }

  it { should belong_to :user }
  it { should have_many :orders }

  it { should validate_presence_of :country }
  it { should validate_presence_of :city }
  it { should validate_presence_of :street }
  it { should validate_presence_of :zip }
  it { should validate_presence_of :phone }
  it { should validate_presence_of :user_id }

  it 'returns a post address' do
    expect(subject.full_address).to eq("#{subject.user.name}, #{subject.street}, #{subject.zip} #{subject.city}")
  end
end
