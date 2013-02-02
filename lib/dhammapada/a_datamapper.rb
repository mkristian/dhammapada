require 'dm-migrations'
require 'dm-validations'
require 'dm-aggregates'
require 'dm-timestamps'

require 'ixtlan/optimistic/data_mapper'
DataMapper::Model.append_inclusions(Ixtlan::Optimistic::DataMapper)

require 'ixtlan/user_management/user_resource'
