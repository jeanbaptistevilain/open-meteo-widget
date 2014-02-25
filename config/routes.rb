Forecasts::Application.routes.draw do

  resources :forecasts, :only => [:new, :index, :create]

  get '/widget' => 'forecasts#widget'

  root :to => 'forecasts#new'

end
