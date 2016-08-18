Rails.application.routes.draw do
  resources :articles
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
