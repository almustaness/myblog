Rails.application.routes.draw do
  get 'authors/index'

 resources :articles do
   member do
     post 'vote'
     post 'comments'
     post 'delete_comments'
   end
 end
 
 root "articles#index"
 resources :categories
 resources :comments
 resources :authors, except: [:new]
 get '/register', to: 'authors#new'
 
 get '/login', to: "login#new"
 post '/login', to: "login#create"
 get '/logout', to: "login#destroy"

end
