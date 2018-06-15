Rails.application.routes.draw do
  root "url#index"
  post '/url',to: 'url#create'
  get '/:url' ,to: 'url#redirect'
end
