namespace :media_jfx do

  desc "Reset Database"
  task :reset_database => :environment do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
  end

end