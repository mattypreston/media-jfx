require 'api_constraints'

MediaJfx::Application.routes.draw do
  resources :schedules
  resources :packages
  resources :devices
  resources :sites
  get "home/index"
  devise_for :users

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      get 'users/get_users/:device_id' => 'users#get_users'
      get 'media/get_fxml/:device_id' => 'media#get_fxml'
    end
  end

  root :to => 'home#index'

end
