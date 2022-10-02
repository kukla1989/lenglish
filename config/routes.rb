Rails.application.routes.draw do
  devise_for :users
  resources :articles do
    member do
      get :renglish
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"
end