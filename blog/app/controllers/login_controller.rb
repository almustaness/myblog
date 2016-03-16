class LoginController < ApplicationController
  
  def new
  end
  
  def create
    #We do not need instance variable because this is in FORM_TAG not MODEL-BACK FORM (FORM_FOR)
    auth = Author.find_by(email: params[:email])
    if auth && auth.authenticate(params[:password])
      flash[:sucess] = "You have logged in successfully ^_^"
      session[:author_id] = auth.id
      redirect_to articles_path
    else
      flash.now[:danger] = "The entered email or password is not correct!"
      render 'new'
    end
  end
  
  def destroy
   session[:author_id] = nil
   flash[:success] = "You have logged out successfully"
   redirect_to root_path
  end
  
end