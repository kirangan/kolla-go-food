class OrdersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
  include CurrentCart
  
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :cart_not_empty, only: [:new]


  def index
    @orders = Order.all

    if params[:name_s] || params[:address_s] || params[:email_s] || params[:min_price] 

      @orders = Order.where('name Like ? AND address Like ? AND email Like ? AND total_price > ?' , "%#{params[:name_s]}%", "%#{params[:address_s]}%", "%#{params[:email_s]}%", "#{params[:min_price].to_i}")
      if !(params[:max_price].empty?)
        @orders = @orders.where( 'total_price < ?',"#{params[:max_price].to_i}")
      end

    end

  end

  def show
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(order_params)
    @order.add_line_items(@cart)
    @order.total_price = @order.total
   
    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil

       # OrderMailer.received(@order).deliver!

        format.html { redirect_to store_index_url, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }       
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_order
    @order = Order.find(params[:id])
  end
    
  def order_params
    params.require(:order).permit(:name, :address, :email, :payment_type, :voucher_id, :total_price, :name_s, :address_s, :email_s, :min_price, :max_price)
  end

  def cart_not_empty
    if @cart.line_items.empty?
      redirect_to store_index_path, notice: "Your cart is empty"
    end
  end
end