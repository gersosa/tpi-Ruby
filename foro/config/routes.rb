Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/users', to: 'users#register'
  post   "/sessions", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
