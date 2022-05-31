Rails.application.routes.draw do
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
  post "users/:id/update" => "users#update"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  get "posts/:id/destroy" => "posts#destroy"
  get "users/:id/edit" => "users#edit"
  get "posts/:id" => "posts#show"
  
  # Defines the root path route ("/")
  # root "articles#index"
end
