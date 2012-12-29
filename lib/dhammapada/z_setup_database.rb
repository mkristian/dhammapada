# -*- coding: utf-8 -*-
require 'dm-sqlite-adapter' unless ENV['DATABASE_URL'] 
require 'dm-migrations'

DataMapper.setup( :default,
                  ENV['DATABASE_URL'] || 'sqlite:db/development.sqlite3' )
DataMapper.finalize
