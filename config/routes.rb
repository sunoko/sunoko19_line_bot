Rails.application.routes.draw do
  post '/callback' => 'webhook#callback'
  get '/tweets/search' => 'tweets#search'
end
