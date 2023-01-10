Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :dishes, only: :show
  patch '/dishes', to: 'dishes#update'

  get "/chefs/:id/ingredients", to: 'chefs_ingredients#index', as: 'chef_ingredients'
  resources :chefs, only: :show
end
