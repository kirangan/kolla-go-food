require 'rails_helper'

describe LineItemsController do
  describe 'POST #create' do
    before :each do
      @food = create(:food)
    end

    it "include CurrentCart" do
      expect(LineItemsController.ancestors.include? CurrentCart).to eq(true)
    end

    context 'with existing line_item with the same food' do
      before :each do
        @cart = create(:cart)
        session[:cart_id] = @cart.id
        line_item = create(:line_item, food: @food, cart: @cart)
      end

      it "does not save the new line_item in the database" do
        expect{
          post :create, params: {food_id: @food.id}
        }.not_to change(LineItem, :count)
      end

      it "increments the quantity of line_item with the same food" do
        expect{
          post :create, params: { food_id: @food.id }
        }.to change {
          @cart.line_items.find_by(food_id: @food.id).quantity
        }.by(1)
      end
    end

    context "without existing line_item with the same food" do
      it "saves the new line_item in the database" do
        expect{
          post :create, params: { food_id: @food.id }
        }.to change(LineItem, :count).by(1)
      end
    end

   

  end

  #   it "saves the new line_item in the database" do
  #     expect {
  #         post :create, params: { food_id: @food.id }
  #       }.to change(LineItem, :count).by(1)
  #   end

  #   it "redirects to cart#show" do 
  #     post :create, params: { food_id: @food.id }
  #     expect(response).to redirect_to(cart_path(assigns[:line_item].cart))
  #   end
   
end