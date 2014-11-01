Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :trainers
  resources :trainers

  patch 'pokemons/arg1' , to: 'pokemons#capture', as: 'capture'
  patch 'pokemons/arg2' , to: 'pokemons#damage' , as: 'attack'

  get   'pokemons/new'  , to: 'pokemons#new'    
  post  'pokemons/arg3'  , to: 'pokemons#create' , as: 'create_pokemon'

end
