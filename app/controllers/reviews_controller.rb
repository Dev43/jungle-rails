class ReviewsController < ApplicationController

before_filter :authorize

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new({description: params[:review][:description], rating: params[:rating]})
    @review.user = current_user
    if @review.save
      redirect_to @product
    else
      render 'products/show'
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    puts @product.reviews.destroy(params[:id])
    redirect_to @product
  end

end
