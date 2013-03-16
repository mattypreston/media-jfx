require 'api_constraints'

MediaJfx::Application.routes.draw do

  resources :schedules, :packages,
            :devices, :sites
  resources :assets, path: '/controllers' do
    put 'assets/:id/add_image_to_asset'=>'assets#add_image_to_asset', :defaults => { :format => 'json' }
  end



  get "home/index"
  devise_for :users



  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      get 'users/get_users/:device_id' => 'users#get_users'
      get 'media/get_fxml/:device_id' => 'media#get_fxml'
      get 'media/get_package/:device_id/:date_time' => 'media#get_package'
      get 'media/get_asset/:package_id/:asset_id' => 'media#get_asset'
    end
  end

  root :to => 'home#index'

end
