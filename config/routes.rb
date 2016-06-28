Rails.application.routes.draw do
  root 'tickets#index' 
  resources :tickets, only: [:show, :index]
end
