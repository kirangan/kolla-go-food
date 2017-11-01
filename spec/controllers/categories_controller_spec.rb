require 'rails_helper'

describe CategoriesController do
  describe 'GET #index' do
    it "populates an array of all categories" do
      dessert = create(:category, name: "Dessert")
      main_course = create(:category, name: "Main Course")
      get :index
      expect(assigns(:categories)).to match_array([dessert, main_course])
    end

    
  end
end