Rails.application.routes.draw do
  root 'main#index'
  
  get 'main/index'
  get '/result', to: 'main#result'
  post '/shorten', to: 'main#shorten'



  get '/:short_url', to: 'main#redirect'
end
