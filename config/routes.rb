Rails.application.routes.draw do
  get '/birds' => 'birds#index'
  get '/birds/:id' => 'birds#show'
  post '/birds' => 'birds#create'
  delete '/birds/:id' => 'birds#delete'

  root to: 'home#index'
end
