require 'rails_helper'

describe AccountController, type: :controller do
  login_user

  it { should use_before_filter(:authenticate_user!) }
  it { should use_after_action(:verify_authorized) }

  describe "GET #show" do
    it "assigns the current_user to @user" do
      get :show
      expect(assigns(:user)).to eq(subject.current_user)
      expect(assigns(:addresses)).to eq(subject.current_user.addresses)
    end

    it "renders the :account view" do
      get :show
      expect(response).to render_template :show
    end
  end
end
