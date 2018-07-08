Rails.application.routes.draw do
  get 'users/new'

  root "urls#index"
  post '/url',to: 'urls#create'
  get '/:url' ,to: 'urls#redirect'
end
