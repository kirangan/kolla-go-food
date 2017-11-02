class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :cart_not_empty, only: [:new]


  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
        @cart.destroy
        session[:cart_id] = nil
        
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end


  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def set_order
    @order = Order.find(params[:id])
  end
    
  def order_params
    params.require(:order).permit(:name, :address, :email, :payment_type)
  end

  def cart_not_empty
    if @cart.line_items.empty?
      redirect_to store_index_path
    end
  end
end