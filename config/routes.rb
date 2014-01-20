Forecasts::Application.routes.draw do

  resources :forecasts, :only => [:new, :create]

  get '/widget' => 'forecasts#widget'

  root :to => 'forecasts#new'

end
