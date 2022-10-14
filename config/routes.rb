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
    end
  end

  root "articles#index"
end
