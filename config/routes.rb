Rails.application.routes.draw do
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
  end
  get 'users/index' => "users#index"
  get "users/:id" => "users#show"
  get "signup" => "users#new"
  post "users/create" => "users#create"
  get 'posts/index' => "posts#index"
  get "/" => "home#top"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "about" => "home#about"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"  
  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"
  get "users/:id/likes" => "users#likes"
  post "users/:id/update" => "users#update"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  get "posts/:id/destroy" => "posts#destroy"
  get "users/:id/edit" => "users#edit"
  get "posts/:id" => "posts#show"
  
  # Defines the root path route ("/")
  # root "articles#index"
end
