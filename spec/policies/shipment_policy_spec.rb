require "rails_helper"

describe ShipmentPolicy do
  subject { described_class }

  let(:admin) { FactoryGirl.create(:admin) }
  let(:user) { FactoryGirl.create(:user) }

  permissions :index? do
    it "denies access to user" do
      expect(subject.new(user, Shipment.new).index?).to eq false
    end

    it "grants access to admin" do
      expect(subject.new(admin, Shipment.new).index?).to eq true
    end
  end

  permissions :show? do
    it "denies access to user" do
      expect(subject).not_to permit(user, Shipment.new)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, Shipment.new)
    end
  end

  permissions :edit? do
    it "denies access to user" do
      expect(subject).not_to permit(user, Shipment.new)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, Shipment.new)
    end
  end

  permissions :new? do
    it "denies access to user" do
      expect(subject).not_to permit(user, Shipment.new)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, Shipment.new)
    end
  end

  permissions :create? do
    it "denies access to user" do
      expect(subject).not_to permit(user, Shipment.new)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, Shipment.new)
    end
  end

  permissions :update? do
    it "denies access to user" do
      expect(subject).not_to permit(user, Shipment.new)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, Shipment.new)
    end
  end

  permissions :destroy? do
    it "denies access to user" do
      expect(subject).not_to permit(user, Shipment.new)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, Shipment.new)
    end
  end
end

