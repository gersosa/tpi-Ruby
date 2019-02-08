Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/users', to: 'users#register'
  post   "/sessions", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  post '/questions', to: 'question#create'
  get '/questions', to: 'question#index'


  post '/answers', to: 'answer#create'
  get '/answers', to: 'answer#index'

end
