require 'rails_helper'

describe UsersController, type: :controller do
  it { should use_before_filter(:authenticate_user!) }
  it { should use_after_action(:verify_authorized) }

  context 'admin' do
    login_admin

    describe "GET #index" do
      it "assigns the users as @items" do
        get :index
        expect(assigns(:items)).to eq([subject.current_user])
      end

      it "renders the :index view" do
        get :index
        expect(response).to render_template :index
      end

    end

    describe "GET #show" do
      it "assigns the user to @user and renders the :show view" do
        get :show, id: subject.current_user
        expect(response).to render_template :show
      end
    end
  end

  context 'user' do
    login_user

    describe "GET #index" do
      it "denies access to users page and shows a flash message" do
        get :index

        should set_the_flash.to('You are not authorized to perform this action')
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
