Rails.application.routes.draw do

  get 'password_resets/new'

  get 'password_resets/edit'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'static_pages/home'
  get  '/signup',  to: 'doctors#new'
  post '/signup',  to: 'doctors#create'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get 'patients/index'
  get 'patients/new'
  get 'patients/edit'
  get 'patients/show'

  get 'appointments/index'
  get 'appointments/new'
  get 'appointments/create'
  get 'appointments/edit'
  get 'appointments/show'

  get 'doctors/index'

  root 'static_pages#home'

  resources :doctors
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :appointments,          only: [:index, :create, :edit, :destroy, :new, :show, :update]
  resources :patients
end
