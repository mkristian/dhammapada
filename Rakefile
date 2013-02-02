# -*- mode: ruby -*-

$LOAD_PATH << 'lib' unless $LOAD_PATH.member? 'lib'

desc 'triggers the update of remote resources'
task :update => [:environment] do
    sync = Updater.new
    sync.do_it

    puts "#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}\n\t#{sync}"
end

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
    require 'seeds'
    warn "[DataMapper] Finished seeding the db!"
  end

  task :setup => [:automigrate, :seed] do
    warn "[DataMapper] Finished db setup!"
  end

end

task :headers do
  require 'rubygems'
  require 'copyright_header'

  args = {
    :license => 'AGPL3',
    :copyright_software => 'dhammapada app',
    :copyright_software_description => 'webapp to browse and display two translations of the Dhammapada.',
    :copyright_holders => ['Christian Meier'],
    :copyright_years => [Time.now.year],
    :add_path => ['lib', 'app', 'src', 'db/seeds.rb'].join( File::PATH_SEPARATOR ),
    :output_dir => './'
  }

  command_line = CopyrightHeader::CommandLine.new( args )
  command_line.execute
end
