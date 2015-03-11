require 'rails_helper'

describe AccountController, type: :controller do
  it { should use_before_filter(:authenticate_user!) }
  it { should use_after_action(:verify_authorized) }

  context 'guest' do
    describe "GET #show" do
      it "redirects to sign_in path" do
        get :show
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context 'user' do
    login_user

    describe "GET #show" do
      it "assigns the current_user to @user and renders the :account view" do
        get :show
        expect(assigns(:user)).to eq(subject.current_user)
        expect(response).to render_template :show
      end
    end
  end

  context 'admin' do
    login_admin
    describe "GET #show" do
      it "assigns the current_user to @user and renders the :account view" do
        get :show
        expect(assigns(:user)).to eq(subject.current_user)
        expect(response).to render_template :show
      end
    end
  end
end
