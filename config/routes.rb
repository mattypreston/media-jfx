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
      get 'media/get_packages_for_device/:device_id' => 'media#get_packages_for_device'
      get 'media/get_package/:package_id' => 'media#get_package'
      post 'media/force_schedule_to_be_current/:schedule_id' => 'media#force_schedule_to_be_current'
      post 'media/remove_force_flag_from_schedule/:schedule_id' => 'media#remove_force_flag_from_schedule'
      get 'authentication/get_token/:user_name' => 'authentication#get_token'

    end
  end

  root :to => 'home#index'

end
