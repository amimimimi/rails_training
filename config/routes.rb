Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  devise_for :admins, path: 'admins', controllers: {
    sessions: "admins/sessions",
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :my_threads do
    resources :comments, module: 'my_threads'
  end

  resources :articles do
    member do
      post :favorite
    end
    get :favorites, on: :collection
  end

  namespace :admins do
    resources :users, only: [:index, :destroy]
    resources :articles, only: [:index, :destroy]
    root 'articles#index'
  end

  root 'articles#index'
end
