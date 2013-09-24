$LOAD_PATH << File.dirname( __FILE__ )
require 'json_setup'

require 'dm-core'
DataMapper::Logger.new(STDOUT, :debug)

require 'datamapper'

# for convienence in the console
Err=Ixtlan::Errors::Error
Audit=Ixtlan::Audit::Audit
Configuration = Ixtlan::Configuration::Configuration

require 'dhammapada/app'
