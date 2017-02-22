Rails.application.routes.draw do
  resources :profiles, except: [:index, :create, :destroy] do
    resources :ads, controller: 'profiles/ads' do
      get 'archive', to: 'ads/archive', on: :collection
      get 'find_category', to: 'ads/find_category', on: :collection
      get 'find_category', to: 'ads/find_category'
    end
    get 'find_city', to: 'profiles/find_city'
  end

  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/brainstorage', as: 'rails_admin'

  resources :photos
  resources :articles
  resources :ads do
    get 'search', to: 'ads/search', on: :collection
  end

  devise_for :users, controllers: { registrations: 'users/registrations' }

  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_out', to: 'users/sessions#destroy'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
