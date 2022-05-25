Rails.application.routes.draw do
  get 'posts/index' => "posts#index"
  get "/" => "home#top"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "about" => "home#about"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  # Defines the root path route ("/")
  # root "articles#index"
end
