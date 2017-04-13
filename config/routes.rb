Rails.application.routes.draw do

  root to: 'welcome#index'
  get 'welcome/index'

  resources :users, only: [:edit, :update, :show] do
    resources :fields, only: [] do
      delete ':resource/:key', to: 'fields#destroy', as: :delete, on: :collection
      get ':resource/new', to: 'fields#new', as: :new, on: :collection
      post ':resource', to: 'fields#create', as: :create, on: :collection
      get ':resource/:key/edit', to: 'fields#edit', as: :edit, on: :collection
      put ':resource/:key', to: 'fields#update', as: :update, on: :collection
    end
  end

end
