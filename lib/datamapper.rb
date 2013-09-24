require 'dm-migrations'
require 'dm-validations'
require 'dm-aggregates'
require 'dm-timestamps'

require 'ixtlan/optimistic/data_mapper'
DataMapper::Model.append_inclusions(Ixtlan::Optimistic::DataMapper)

require 'ixtlan/user_management/user_resource'
require 'ixtlan/errors/resource'
require 'ixtlan/audit/resource'
# need encrypted cookie to get the respective attribute in configuration
require 'encrypted_cookie'
require 'ixtlan/configuration/resource'

DataMapper.setup( :default,
                  ENV['DATABASE_URL'] || 'sqlite:db/development.sqlite3' )
DataMapper.finalize
