require 'rails_helper'

describe CategoriesController do
  describe 'GET #index' do
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

  describe 'GET #show' do
    it "assigns the requested category to @category" do
      category = create(:category)
      get :show, params: { id: category }
      expect(assigns[:category]).to eq category
    end
  end
end