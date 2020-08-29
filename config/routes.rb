Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # zoom関連
  # get "zooms", to: 'zooms#index'
  post "zooms", to: 'zooms#create'
  get "zooms/new", to: 'zooms#new'

  get 'zooms/list/:uuid', to: 'zooms#list'
  get 'zooms/share/:uuid', to: 'zooms#share'

  # recipe関連
  get "recipes", to: 'recipes#index'
  post "recipes", to: "recipes#create"
  post 'recipes/poll', to: 'recipes#poll'

  root 'zooms#new'
end
