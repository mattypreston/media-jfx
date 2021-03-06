#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "bundler/capistrano"
require 'rvm/capistrano'

set :bundle_cmd, 'source $HOME/.bash_profile && bundle'

set :rvm_ruby_string, "1.9.3-p327"
set :rvm_type, :user

server "54.235.197.197", :web, :app, :db, primary: true

set :application, "media-jfx"
set :user, "ubuntu"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :keep_releases, 1
set :scm, "git"
set :repository,  "git@github.com:mattypreston/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" #Keep only the last 5 releases
before "deploy:assets:precompile", "bundle:install"


namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      desc "Changing permissions on Unicorn admin script"
      run "chmod 777 /etc/init.d/unicorn_#{application}"
      desc "Restarting Unicorn"
      run "#{sudo} /etc/init.d/unicorn_#{application} #{command}"
      desc "Restarting Nginx"
      run "#{sudo} service nginx #{command}"
    end
  end

  task :uploads_folder do
    run "mkdir -p #{shared_path}/uploads"
    run "#{sudo} chmod 775 #{shared_path}/uploads"
  end
  after 'deploy:setup', 'carrierwave:uploads_folder'

  task :upload_symlink do
    run "ln -s #{shared_path}/uploads #{current_path}/public"
  end
  after 'deploy', 'deploy:upload_symlink'

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/mongoid.example.yml"), "#{shared_path}/config/mongoid.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/mongoid.yml #{release_path}/config/mongoid.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  #desc "Make sure local git is in sync with remote."
  #task :check_revision, roles: :web do
  #  unless 'git rev-parse HEAD' == 'git rev-parse origin/master'
  #    puts "WARNING: HEAD is not the same as origin/master"
  #    puts "Run 'git push' to sync changes."
  #    exit
  #  end
  #end
  #before "deploy", "deploy:check_revision"

end
