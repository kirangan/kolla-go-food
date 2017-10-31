require 'rails_helper'

describe DrinkController do
  describe 'GET #index' do
    context 'with params[:letter]' do
      it "populates an array of drinks starting with the letter" do
        fun_sode = create(:drink, name: "Fun Soda")
        big_cloud = create(:drink, name: "Big Cloud")
        get :index, params: { letter: 'F' }
        expect(assigns(:drinks)).to match_array([fun_sode])
      end

      it "renders the :index template" do
        get :index, params: { letter: 'F' }
        expect(response).to render_template :index
      end
    end