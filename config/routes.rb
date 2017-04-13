Rails.application.routes.draw do

  root to: 'welcome#index'
  get 'welcome/index'

  resources :users, only: [:edit, :update, :show]

end
