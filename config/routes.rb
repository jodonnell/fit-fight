Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  post 'daily-exercise', to: 'welcome#update'
end
