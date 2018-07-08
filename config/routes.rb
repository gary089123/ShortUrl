Rails.application.routes.draw do
  get 'sessions/new'

  get '/user/signup' ,to:'users#new'
  get '/user' ,to: 'users#index'
  post '/user/signup' , to: 'users#create'

  get 'user/login' ,to:'sessions#new'
  post 'user/login',to: 'sessions#create'
  get 'user/logout', to: 'sessions#destroy'

  root "urls#index"
  post '/url',to: 'urls#create'
  get '/:url' ,to: 'urls#redirect'
end
