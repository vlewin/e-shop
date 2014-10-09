require "rails_helper"

describe Address do
  subject { FactoryGirl.build(:address) }

  it { should belong_to :user }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :city }
  it { should validate_presence_of :street }
  it { should validate_presence_of :zip }
  it { should validate_presence_of :phone }
  it { should validate_presence_of :user_id }

  it 'returns a full username' do
    expect(subject.full_name).to eq("#{subject.first_name} #{subject.last_name}")
  end

  it 'returns a post address' do
    expect(subject.full_address).to eq("#{subject.full_name}, #{subject.street}, #{subject.zip} #{subject.city}")
  end
end
