class Admin::CategoriesController < ApplicationController

  def index
    @category = Category.all
  end

  def new
    @category = Category.new
  end


  def create
    puts category_params
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category Created!'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end


end
