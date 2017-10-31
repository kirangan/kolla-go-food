require 'rails_helper'

describe CategoriesController do
  describe "GET #index" do
    it "populates an array of all categories" do
      dessert = create(:category, name: "Dessert")
      main_course = create(:category, name: "Main Course")
      get :index
      expect(assigns(:categories)).to match_array([dessert, main_course])
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested category to @category" do
      category = create(:category)
      get :show, params: { id: category }
      expect(assigns(:category).to eq category)
    end

    it "populates a list of all foods in the category" do
      category = create(:category)
      food1 = create(:food, category: category)
      food2 = create(:food, category: category)
      get :show, params: { id: category }
      expect(assigns(:category).foods).to match_array([food1, food2])
    end

    it "renders the :show template" do
      category = create(:category)
      get :show, params: { id: category }
      expect(response).to render_template :show
    end
  end

   describe 'GET #new' do
    it "assigns a new category to @category" do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
    it "renders the :new template" do 
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "assigns the requested category to @category" do
      category = create(:category)
      get :edit, params: { id: category }
      expect(assigns(:category)).to eq food
    end

    it "renders the :show template" do
      food = create(:food)
      get :edit, params: { id: food }
      expect(response).to render_template :edit
    end
  end

  describe 'DELETE #destroy' do 
    before :each do
      @category = create(:category)
    end

    context "with associated foods" do
      it "does not delete the category from the database" do
        food = create(:food, category: @category)
        expect{
          delete :destroy, params: { id: @category }
        }.not_to change(Category, :count)
      end
    end

    context "without associated food" do
      it "deletes the category from the database" do
        expect{
          delete :destroy, params: { id: @category }
        }.to change(Category, :count).by(-1)
      end
      it "redirects to categories#index" do
        delete :destroy, params: { id: @category }
        expect(response).to redirect_to categories_url
      end
    end
  end
end