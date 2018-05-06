Rails.application.routes.draw do
  get 'maps/index'
  # see http://guides.rubyonrails.org/routing.html
  root to: 'maps#index'
  get 'maps/request_categories', to: 'maps#request_categories'
  get 'federal_states/index'
  get 'maps/:id', to: 'maps#show'
  get 'maps/category/:category', to: 'maps#get_category_values'
  get 'api/documentation', to: 'api/documentation#show'
  resources :data_portals

  namespace :api, defaults: {format: :json} do
    resources :data_portals, only: [:index] do
      get 'markers', on: :collection
      get 'details', on: :collection
    end
    resources :progress, only: [:index]
    resources :cities, only: [:index]
    resources :categories, only: [:index]
  end
end
