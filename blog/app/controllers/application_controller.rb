class ApplicationController < ActionController::Base
  
  helper_method :current_user, :logged_in?, :check_admin, :user_thumbs_counter, :user_thumbs
  
  
  
  
  def current_user
    @current_user ||= Author.find(session[:author_id]) if session[:author_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "Log in to perform this action"
      redirect_to root_path
    end
  end
  
   def check_admin
     if logged_in?
       if !Author.find(session[:author_id]).admin
         flash[:danger] = "You do not have permission to add a category"
         redirect_to root_path
       end
     else
       flash[:danger] = "Log in to perform this action"
       redirect_to root_path
     end
   end
   
   def require_owner
     if logged_in?
       @owner = Article.find(params[:id]).author
       if Author.find(session[:author_id]) != @owner && !Author.find(session[:author_id]).admin
         flash[:danger] = "You do not have permission for editing"
         redirect_to root_path
       end
     else
       flash[:danger] = "Please login to perform this action"
       redirect_to login_path
     end
   end
   
     
   def user_thumbs_counter
    t_user = Thumb.where(:author_id => session[:author_id], :article_id => 63, :vote=>"like").all.length
   end
   
   def user_thumbs
    t_user = Thumb.where(:author_id => session[:author_id]).all
   end
  
  protect_from_forgery with: :exception
  
end
