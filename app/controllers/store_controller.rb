class StoreController < ApplicationController
  include CurrentCart
  skip_before_action :authorize
  before_action :set_cart
  
  def index
    @restaurants = Restaurant.order(:name)
  	@foods = Food.order(:name)
    @tags = Tag.order(:name)
  end

end
