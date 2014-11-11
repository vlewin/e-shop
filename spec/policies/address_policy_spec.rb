require "rails_helper"

describe AddressPolicy do
  subject { described_class }

  let(:admin) { FactoryGirl.create(:admin) }
  let(:user) { FactoryGirl.create(:user_with_addresses) }
  let(:address) { FactoryGirl.create(:address) }
  let(:user_address) { user.addresses.first }

  permissions :index? do
    it "denies access to user" do
      expect(subject.new(user, address).index?).to eq false
    end

    it "grants access to admin" do
      expect(subject.new(admin, address).index?).to eq true
    end
  end

  permissions :show? do
    it "denies access to user" do
      expect(subject).not_to permit(user, address)
    end

    it "grants access to user if record belongs to user" do
      expect(subject).to permit(user, user_address)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, address)
    end
  end

  permissions :edit? do
    it "denies access to user" do
      expect(subject).not_to permit(user, address)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, address)
    end
  end

  # permissions :new? do
  #   it "denies access to user" do
  #     expect(subject).not_to permit(user, address)
  #   end

  #   it "grants access to admin" do
  #     expect(subject).to permit(admin, address)
  #   end
  # end

  permissions :update? do
    it "denies access to user" do
      expect(subject).not_to permit(user, address)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, address)
    end
  end

  permissions :destroy? do
    it "denies access to user" do
      expect(subject).not_to permit(user, address)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, address)
    end
  end
end

