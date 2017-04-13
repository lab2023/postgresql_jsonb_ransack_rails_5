Rails.application.routes.draw do
  root to: 'welcome#index_one'
  get 'welcome/index_one'
  get 'welcome/index_second'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
