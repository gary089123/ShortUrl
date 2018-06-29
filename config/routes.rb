Rails.application.routes.draw do
  root "urls#index"
  post '/url',to: 'urls#create'
  get '/:url' ,to: 'urls#redirect'
end
