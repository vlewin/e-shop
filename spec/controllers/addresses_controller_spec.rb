require 'rails_helper'

describe AddressesController, type: :controller do
  login_admin

  let(:address) { FactoryGirl.create(:address)}
  it { should use_before_action(:set_address) }


  describe "GET index" do
    it "assigns all addresses as @addresses" do
      get :index
      expect(assigns(:addresses)).to eq(Address.all)
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the users as @users" do
      get :show, id: address
      expect(assigns(:address)).to eq(address)
    end

    it "renders the :account view" do
      get :show, id: address
      expect(response).to render_template :show
    end
  end

  describe "POST #create" do
    it "is a pending example"
  end

  describe "PUT #update" do
    it "is a pending example"
  end

  describe "DELETE #destroy" do
    it "is a pending example"
  end
end

