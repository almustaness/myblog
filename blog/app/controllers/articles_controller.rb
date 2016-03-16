class ArticlesController < ApplicationController
  before_action :require_user, except: [:show, :index]
  before_action :require_owner, only: [:edit, :update]
  before_action :user_thumbs_counter, :user_thumbs
 
  def index
    @art = Article.all
    @cat = Category.all.reverse
  end
  
  def show
    @art = Article.find(params[:id])
    @comm = @art.comments.new
  end
  
  def comments
    @comm = Comment.create(commBody: params[:commparams][:commBody], article_id: params[:id], author_id: session[:author_id])
    if @comm.save
      flash[:success] = "You have commented"
      redirect_to :back
    end
  end
  
  def delete_comments
    comm = Comment.find(params[:as])
    comm.destroy
     flash[:success] = "The comment has been deleted successfully"
     redirect_to :back
  end
  
  def new
   @art = Article.new
   @cat = Category.all
  end
  
  def create
   
      @cat = Category.all
      @art = Article.new(art_params)
      @art.author_id = session[:author_id]
      cat_id = params[:category][:artCatName].to_i
      @art.category_id = cat_id
       if @art.save
        flash[:success] = "You have posted a new article successfully"
        redirect_to article_path(@art)
       else
        render 'new'
       end
  end

  
  def edit
    @art = Article.find(params[:id])
  end
  
  def update
    @art = Article.find(params[:id])
    if @art.update(art_params)
      flash[:success] = "You have updated the article successfully"
      redirect_to article_path(params[:id])
    else
      render 'edit'
    end
  end
  
  
  
  def destroy
     Article.find(params[:id]).destroy
     flash[:success] = "You have deleted the article successfully"
     redirect_to articles_path
  end
  
  def vote 
   $z = Thumb.where(:author_id => params[:author_id], :article_id => params[:id]).length
      if $z == 0
        Thumb.create(vote: params[:vote], author_id: params[:author_id], article_id: params[:id] )
        if params[:vote]=="like"
           flash[:success] = "You liked the article"
           redirect_to :back
        else
            flash[:success] = "You disliked the article"
            redirect_to :back
        end
      else
         $y = Thumb.where(:author_id => params[:author_id], :article_id => params[:id]).first
          $y.vote = params[:vote]
          $y.save
          if params[:vote]=="like"
           flash[:success] = "You liked the article"
           redirect_to :back
          else
           flash[:success] = "You disliked the article"
           redirect_to :back
      end
   end
  end

  private
   def art_params
     params.require(:article).permit( :artTitle, :artBody)
   end
   
   

  
end
