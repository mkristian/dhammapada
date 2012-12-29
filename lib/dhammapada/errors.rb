# TODO remove that needed require
require 'ixtlan/guard/models'

require 'ixtlan/errors/rack'
require 'ixtlan/errors/dumper'
require 'ixtlan/errors/cuba'

CubaAPI.use( Ixtlan::Errors::Rack, Ixtlan::Errors::Dumper.new do |dumper|
  dumper.from_email = "dhammapada@example.com"
  dumper.to_emails = "dev@example.com"
  #dumper.keep_dumps =
  dumper.base_url = "http://localhost:9292/errors"
end, true ) # dump_to_console 
