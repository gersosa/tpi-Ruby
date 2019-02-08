Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/users', to: 'users#register'
  post   "/sessions", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  post '/questions', to: 'question#create'
  get '/questions', to: 'question#index'
  get '/questions/:id', to: 'question#show'
	put '/questions/:id', to: 'question#update'
	put '/questions/:id/resolve', to: 'question#resolve'
	delete '/questions/:id', to: 'question#destroy'
	get '/questions/:question_id/answers', to: 'question#answers'
	post '/questions/:question_id/answers', to: 'question#answer_in'
	delete '/questions/:question_id/answers/:id', to: 'question#answer_out'

  post '/answers', to: 'answer#create'
  get '/answers', to: 'answer#index'

  root 'welcome#index'

end
