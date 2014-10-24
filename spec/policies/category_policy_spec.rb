require "rails_helper"

describe CategoryPolicy do
  subject { described_class }

  let(:admin) { FactoryGirl.create(:admin) }
  let(:user) { FactoryGirl.create(:user) }

  permissions :index? do
    it "denies access to user" do
      expect(subject.new(user, Category.new).index?).to eq false
    end

    it "grants access to admin" do
      expect(subject.new(admin, Category.new).index?).to eq true
    end
  end

  permissions :show? do
    it "denies access to user" do
      expect(subject).not_to permit(user, Category.new)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, Category.new)
    end
  end

  permissions :edit? do
    it "denies access to user" do
      expect(subject).not_to permit(user, Category.new)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, Category.new)
    end
  end

  permissions :new? do
    it "denies access to user" do
      expect(subject).not_to permit(user, Category.new)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, Category.new)
    end
  end

  permissions :create? do
    it "denies access to user" do
      expect(subject).not_to permit(user, Category.new)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, Category.new)
    end
  end

  permissions :update? do
    it "denies access to user" do
      expect(subject).not_to permit(user, Category.new)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, Category.new)
    end
  end

  permissions :destroy? do
    it "denies access to user" do
      expect(subject).not_to permit(user, Category.new)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, Category.new)
    end
  end
end

