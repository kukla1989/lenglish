Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'users', :to => 'users/registrations#index'
  end


  resources :articles do
    member do
      get :renglish
      get :user_articles
    end
  end
 # get "/:subject", to: "articles#subject"
  root "articles#index"
end
