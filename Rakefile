$LOAD_PATH << 'lib' unless $LOAD_PATH.member? 'lib'

task :environment do
  require 'dhammapada'
end

namespace :db do

  desc 'Perform destructive automigration of all repositories in the current Rails.env'
  task :automigrate => :environment do
    require 'dm-migrations'
    DataMapper.auto_migrate!
    warn "[DataMapper] Finished auto_migrate!"
  end

  desc 'Perform non destructive automigration of all repositories in the current Rails.env'
  task :autoupgrade => :environment do
    require 'dm-migrations'
    DataMapper.auto_upgrade!
    warn "[DataMapper] Finished auto_upgrade!"
  end

  task :seed => :environment do

    warn "TODO db:seed"

  end
end
