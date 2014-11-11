require "rails_helper"

describe OrderPolicy do
  subject { described_class }

  let(:admin) { FactoryGirl.create(:admin) }
  let(:user) { FactoryGirl.create(:user_with_addresses) }
  let(:order) { FactoryGirl.create(:order) }
  let(:user_order) { FactoryGirl.create(:order, user: user) }

  permissions ".scope" do
    context "for an ordinary user" do
      let(:policy_scope) { OrderPolicy::Scope.new(user, Order).resolve }

      it "hides other orders" do
        expect(policy_scope).to eq []
      end

      it "shows user orders" do
        expect(policy_scope).to eq [user_order]
      end
    end

    context "for an admin user" do
      let(:policy_scope) { OrderPolicy::Scope.new(admin, Order).resolve }

      it "shows all orders" do
        expect(policy_scope).to eq [order]
      end
    end
  end

  permissions :index? do
    it "denies access to user" do
      expect(subject.new(user, order).index?).to eq false
    end

    it "grants access to admin" do
      expect(subject.new(admin, order).index?).to eq true
    end
  end

  permissions :show? do
    it "denies access to user" do
      expect(subject).not_to permit(user, order)
    end

    it "grants access to order if record belongs to user" do
      expect(subject).to permit(user, user_order)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, order)
    end
  end

  permissions :edit? do
    it "denies access to user" do
      expect(subject).not_to permit(user, order)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, order)
    end
  end

  permissions :update? do
    it "denies access to user" do
      expect(subject).not_to permit(user, order)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, order)
    end
  end

  permissions :destroy? do
    it "denies access to user" do
      expect(subject).not_to permit(user, order)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, order)
    end
  end
end

