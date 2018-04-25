Rails.application.routes.draw do
  get 'maps/index'
  # see http://guides.rubyonrails.org/routing.html
  root to: 'maps#index'
  resources :data_portals
  get 'maps/request_categories', to: 'maps#request_categories'
  get 'federal_states/index'
  get 'maps/:id', to: 'maps#show'
  get 'maps/category/:category', to: 'maps#get_category_values'
  get 'api/documentation', to: 'api/documentation#show'
end
