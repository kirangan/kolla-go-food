class RestaurantsController < ApplicationController
  skip_before_action :authorize
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  #before_action :set_upcase, only: [:create, :update]
  
  

  def index
    @restaurants = Restaurant.all
    if params[:name_s] || params[:address_s] #|| params[:min_food]
      @restaurants = Restaurant.where('name Like ? AND address Like ? ', "%#{params[:name_s]}%", "%#{params[:address_s]}%")
      if !(params[:min_food].empty?)
        @restaurants = Restaurant.joins(:foods).group(:restaurant_id).having('count(*) > ?', "#{params[:min_food].to_i}")
      end
    end
  end

  def show
  end

  def new
    @restaurant = Restaurant.new
  end

  def edit
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    
    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to restaurants_url, notice: "Restaurant was successfully created." }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, location: @restaurant }
        @restaurants = Restaurant.all

      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
  
  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :name_s, :address_s, :min_food, :max_food)
  end

  
end