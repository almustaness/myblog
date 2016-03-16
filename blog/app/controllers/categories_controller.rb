class CategoriesController < ApplicationController
  before_action :check_admin, except: [:show, :index]
  
  def index
    @cat = Category.all
  end
  
  def show
    @cat = Category.find(params[:id])
   # @catArticles = @cat.articles
  end
  
  def new
    @cat = Category.new
  end
  
  def create
    @cat = Category.new(cat_params)
    if @cat.save
      flash[:success] = "You have created a category sucessfully"
      redirect_to categories_path
    else
      render 'new'
    end
    
  end
  
  def edit
    @cat = Category.find(params[:id])
  end
  
  def update
    @cat = Category.find(params[:id])
    if @cat.update(cat_params)
      flash[:success] = "The category has been updated successfully"
      redirect_to categories_path
    end
  end
  
  def destroy
    if Category.find(params[:id]).destroy
      flash[:success] = "The category has been deleted successfully"
      redirect_to :back
    end
  end
  
  private
   def cat_params
     params.require(:category).permit(:catName)
   end
   

   
end