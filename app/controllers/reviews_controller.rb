class ReviewsController < ApplicationController
  before_action :load_reviewable
  
  def index
    @reviews = @reviewable.reviews
        
  end

  def new
    @review = @reviewable.reviews.new
  end

  def create
    @review = @reviewable.reviews.new(review_params)

    respond_to do |format|
      if @reviewable.save
        format.html { redirect_to [@reviewable, :reviews], notice: "Your note was successfully posted."}
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # def update
  #   respond_to do |format|
  #     if @reviewable.update(review_params)
  #       format.html { redirect_to @review, notice: 'Review was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @review }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @review.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def destroy
    @reviewable.destroy
    respond_to do |format|
      format.html { redirect_to @reviewable.reviews_path, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def review_params
    params.require(:review).permit(:name, :title, :description)
  end

  def load_reviewable
    resource, id = request.path.split('/')[1,2]
    @reviewable = resource.singularize.classify.constantize.find(id)

    # klass = [Food, Restaurant].detect { |c| params["#{c.name.underscore}_id"] }
    # @reviewable = klass.find(params["#{klass.name.underscore}_id"])
  end

end
