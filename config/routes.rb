Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/brainstorage', as: 'rails_admin'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_out', to: 'users/sessions#destroy'
  end

  root 'home#index'

  resources :profiles, except: [:index, :create, :destroy] do
    resources :ads, controller: 'profiles/ads' do
      get 'archive', to: 'ads/archive', on: :collection
    end
  end

  resources :photos
  resources :articles
  resources :ads do
    get 'search', to: 'ads/search', on: :collection
  end

  get 'find_city', to: 'find_cities#show'
  get 'find_category', to: 'find_categories#show'
end
