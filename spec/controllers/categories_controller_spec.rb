require 'rails_helper'

describe CategoriesController, type: :controller do
  let!(:category) { FactoryGirl.create(:category)}

  it { should use_before_action(:set_category) }
  it { should use_after_action(:verify_authorized) }

  context 'guest' do
    describe "GET #index" do
      it "redirects to sign_in path" do
        get :index

        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "GET #show" do
      it "redirects to sign_in path" do
        get :show, id: category

        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "GET #edit" do
      it "redirects to sign_in path" do
        get :edit, id: category

        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "GET #new" do
      it "redirects to sign_in path" do
        get :new

        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "POST #create" do
      it "redirects to sign_in path" do
        post :create, category: { title: 'ABC' }

        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "PUT #update" do
      it "redirects to sign_in path" do
        put :update, id: category

        expect(response).to redirect_to new_user_session_path
      end
    end

    describe "DELETE #destroy" do
      it "redirects to sign_in path" do
        delete :destroy, id: category

        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  context 'user' do
    login_user

    describe "GET #index" do
      it "redirects to root path with flash error message" do
        get :index

        expect(response).to redirect_to root_path
        expect(flash[:error]).to eq "You are not authorized to perform this action"
      end
    end

    describe "GET #show" do
      it "redirects to root path with flash error message" do
        get :show, id: category

        expect(response).to redirect_to root_path
        expect(flash[:error]).to eq "You are not authorized to perform this action"
      end
    end

    describe "GET #edit" do
      it "redirects to root path with flash error message" do
        get :edit, id: category

        expect(response).to redirect_to root_path
        expect(flash[:error]).to eq "You are not authorized to perform this action"
      end
    end

    describe "GET #new" do
      it "redirects to root path with flash error message" do
        get :new

        expect(response).to redirect_to root_path
        expect(flash[:error]).to eq "You are not authorized to perform this action"
      end
    end

    describe "POST #create" do
      it "redirects to root path with flash error message" do
        post :create, category: { title: 'ABC' }

        expect(response).to redirect_to root_path
        expect(flash[:error]).to eq "You are not authorized to perform this action"
      end
    end

    describe "PUT #update" do
      it "redirects to root path with flash error message" do
        put :update, id: category

        expect(response).to redirect_to root_path
        expect(flash[:error]).to eq "You are not authorized to perform this action"
      end
    end

    describe "DELETE #destroy" do
      it "redirects to root path with flash error message" do
        delete :destroy, id: category

        expect(response).to redirect_to root_path
        expect(flash[:error]).to eq "You are not authorized to perform this action"
      end
    end
  end

  context 'admin' do
    login_admin

    describe "GET #index" do
      it "assigns the categories to @items and renders the :index view" do
        get :index

        expect(assigns(:items)).to match_array(Category.all)
        expect(response).to render_template :index
      end
    end

    describe "GET #show" do
      it "assigns the category to @category and renders the :show view" do
        get :show, id: category

        expect(assigns(:category)).to eq(category)
        expect(response).to render_template :show
      end
    end

    describe "GET #edit" do
      it "assigns the category to @category and renders the :edit view" do
        get :edit, id: category

        expect(assigns(:category)).to eq(category)
        expect(response).to render_template :edit
      end
    end

    describe "GET #new" do
      it "assigns the category to Category.new and renders the :new view" do
        get :new

        expect(assigns(:category)).to be_a_new(Category)
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      it "redirects to root path with flash error message" do
        expect { post :create, category: { title: 'ABC' } }.to change(Category, :count)
        expect(Category.last.title).to eq('ABC')

        expect(response).to redirect_to categories_path
      end
    end

    describe "PUT #update" do
      it "redirects to root path with flash error message" do
        put :update, id: category, category: { title: 'XYZ' }

        expect(assigns(:category)).to eq(category)
        expect(Category.last.title).to eq('XYZ')
        expect(response).to redirect_to categories_path
      end
    end

    describe "DELETE #destroy" do
      it "redirects to root path with flash error message" do
        expect { delete :destroy, id: category }.to change(Category, :count)
        expect(response).to redirect_to categories_path
      end
    end
  end
end
