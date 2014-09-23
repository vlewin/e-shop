require 'rails_helper'

describe AccountController, type: :controller do
  login_user

  it { should use_before_filter(:authenticate_user!) }
  it { should use_after_action(:verify_authorized) }

  describe "GET #show" do
    it "assigns the current_user to @user" do
      get :show
      expect(assigns(:user)).to eq(subject.current_user)
      expect(assigns(:address)).not_to be nil
    end

    it "renders the :account view" do
      get :show
      expect(response).to render_template :show
    end

    it "adds breadcrumb items" do
      expect(subject).to receive(:add_breadcrumb).with('Home', :root_path)
      expect(subject).to receive(:add_breadcrumb).with('Account settings', account_url)

      get :show
    end
  end
end