Rails.application.routes.draw do
  get '/users/signup' ,to:'users#new'
  get '/user' ,to: 'users#index'
  post '/users/signup' , to: 'users#create'

  root "urls#index"
  post '/url',to: 'urls#create'
  get '/:url' ,to: 'urls#redirect'
end
