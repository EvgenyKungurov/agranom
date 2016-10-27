Rails.application.routes.draw do
  resources :profiles do
    get 'find_city', to: 'profiles/find_city'
  end

  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/brainstorage', as: 'rails_admin'

  resources :articles
  resources :ads

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_out', to: 'users/sessions#destroy'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
