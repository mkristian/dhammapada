# -*- coding: utf-8 -*-
require 'dm-sqlite-adapter'
require 'dm-migrations'

DataMapper.setup( :default, #"sqlite3::memory:" )
                  ENV['DATABASE_URL'] || 'sqlite:db/development.sqlite3' )
DataMapper.finalize
