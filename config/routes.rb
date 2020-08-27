Rails.application.routes.draw do
  get 'zoom/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :zooms
  resources :recipes
  get 'zoom/list/:uuid', to: 'zooms#list'
  get 'zoom/share/:uuid', to: 'zooms#share'
  post 'recipes/increment', to: 'recipes#increment'
  
  root 'zooms#new'
end
