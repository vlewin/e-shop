require "rails_helper"

describe UserPolicy do
  subject { described_class }

  let(:admin) { FactoryGirl.create(:admin) }
  let(:user) { FactoryGirl.create(:user) }

  permissions :index? do
    it "denies access to user" do
      expect(subject.new(user, User.new).index?).to eq false
    end

    it "grants access to admin" do
      expect(subject.new(admin, User.new).index?).to eq true
    end
  end

  permissions :show? do
    it "denies access to user" do
      expect(subject).not_to permit(user, User.new)
    end

    it "grants access to user if record belongs to user" do
      expect(subject).to permit(user, user)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, User.new)
    end
  end

  permissions :edit? do
    it "denies access to user" do
      expect(subject).not_to permit(user, User.new)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, User.new)
    end
  end

  permissions :new? do
    it "denies access to user" do
      expect(subject).not_to permit(user, User.new)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, User.new)
    end
  end

  permissions :update? do
    it "denies access to user" do
      expect(subject).not_to permit(user, User.new)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, User.new)
    end
  end

  permissions :destroy? do
    it "denies access to user" do
      expect(subject).not_to permit(user, User.new)
    end

    it "grants access to admin" do
      expect(subject).to permit(admin, User.new)
    end
  end
end

