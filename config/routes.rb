Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  get 'simulate', to: 'welcome#simulate_form'
  post 'simulate', to: 'welcome#simulate'
  post 'daily-exercise', to: 'welcome#update'
end
