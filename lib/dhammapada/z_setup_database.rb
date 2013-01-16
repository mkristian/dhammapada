# -*- coding: utf-8 -*-

# adjust or (un)comment as needed
#DataMapper::Logger.new($stdout, :debug) 

DataMapper.setup( :default,
                  ENV['DATABASE_URL'] || 'sqlite:db/development.sqlite3' )
DataMapper.finalize
