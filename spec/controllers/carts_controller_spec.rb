require 'rails_helper'

describe CartsController, type: :controller do
  let(:cart) { FactoryGirl.create(:cart) }
  let(:empty_cart) { FactoryGirl.create(:empty_cart) }

  it { should use_before_filter(:authenticate_user!) }
  it { should use_after_action(:verify_authorized) }


  context 'guest' do
    describe "GET #index" do
      it "redirects to new_user_session_path" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "GET #show" do
      it "redirects to root_path" do
        get :show, id: cart
        expect(response).to redirect_to root_path
      end
    end
  end

  context 'user' do
    login_user


    describe "GET #index" do
      it "redirects to root_path" do
        get :index
        expect(response).to redirect_to root_path
      end

      it "sets flash[:error]" do
        get :index
        expect(flash[:error]).to eq "You are not authorized to perform this action"
      end
    end

    describe "GET #show" do
      it "is a pending example"
    end
  end

  context 'admin' do
    login_admin

    describe "GET #index" do
      it "assigns carts to @items" do
        get :index
        expect(assigns(:items)).to match_array(Cart.all)
      end

      it "renders index view" do
        get :index
        expect(response).to render_template :index
      end
    end
  end
end
