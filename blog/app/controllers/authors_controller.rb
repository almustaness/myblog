class AuthorsController < ApplicationController
  def index
    @auth = Author.all
  end
  
  def show
    @auth = Author.find(params[:id])
    @art = Article.all
  end
  
  def new
    @auth = Author.new
  end
  
  def create
    @auth = Author.new(auth_params)
    if @auth.save
      session[:author_id] = @auth.id
      flash[:success] = "Your account is created successfully" 
      redirect_to articles_path
    else
      render 'new'
    end
  end
  
  def edit
    @auth = Author.find(params[:id])
  end
  
  def update
    @auth = Author.find(params[:id])
    if @auth.update(auth_params)
      flash[:success] = "You have updated you profile successfully"
      redirect_to author_path(params[:id])
    else
      render 'edit'
    end
  end
  
  def destroy
    @auth = Author.find(params[:id])
    if @auth.destroy
      flash[:success] = "The author has been deleted successfully"
      redirect_to authors_path
    end
  end
  
  private
   def auth_params
     params.require(:author).permit(:authName, :email, :password)
   end
  
end
