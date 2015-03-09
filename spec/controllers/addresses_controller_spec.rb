require 'rails_helper'

describe AddressesController, type: :controller do
  login_admin

  let!(:address) { FactoryGirl.create(:address)}
  it { should use_before_action(:set_address) }


  describe "GET #index" do
    it "assigns addresses to @items" do
      get :index
      expect(assigns(:items)).to match_array(Address.all)
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "assigns @address" do
      get :show, id: address
      expect(assigns(:address)).to eq(address)
    end

    it "renders the :account view" do
      get :show, id: address
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    before { get :new }

    it "assigns @address" do
      expect(assigns(:address)).to be_a_new(Address)
    end

    it "renders the new view" do
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    ActiveRecord::Base.logger = nil
    context "when valid" do
      before { post :create, address: FactoryGirl.build(:address).attributes }

      it "redirects to addresses path" do
        expect(response).to redirect_to(addresses_path)
      end

      it "sets flash[:notice]" do
        expect(flash[:notice]).to be_present
      end
    end

    context "when invalid" do
      before { post :create, address: { recipient: 'Foo'} }

      it "renders new template" do
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET #edit" do
    before { get :edit, id: address.id }

    it "assigns @address" do
      expect(assigns(:address)).to eq(address)
    end

    it "renders the edit template" do
      expect(response).to render_template("edit")
    end
  end

  describe "PUT #update" do
    context "when success" do
      before { put :update, address: {recipient: "Update recipient", city: "Update city"}, id: address.id }

      it "redirects to root path" do
        expect(response).to redirect_to addresses_path
      end

      it "sets flash[:notice]" do
        expect(flash[:notice]).to be_present
      end
    end

    context "when not success" do
      before { put :update, address: {recipient: "", city: ""},id: address.id }

      it "renders new template" do
        expect(response).to render_template("new")
      end
    end
  end

  describe "DELETE #delete" do
    before { delete :delete, id: address.id }

    it " will redirect to account path" do
      expect(response).to redirect_to account_path
    end

    it "will set flash[:notice]" do
      expect(flash[:notice]).to be_present
    end
  end

  describe "DELETE #destroy" do
    before { delete :destroy, id: address.id }

    it " will redirect to addresses path" do
      expect(response).to redirect_to addresses_path
    end

    it "will set flash[:notice]" do
      expect(flash[:notice]).to be_present
    end
  end

end

