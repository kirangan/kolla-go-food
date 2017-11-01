class CategoriesController < ApplicationController

  before_action :set_category, only: [:show, :edit, :update, :destroy]
  
  def index
    @categories = Category.all
  end

  def show
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        
    end
  end

  private
  def set_category
    @Category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end