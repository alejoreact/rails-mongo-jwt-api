Rails.application.routes.draw do
  resources :users
  post :login, to: 'auth#create'
end
