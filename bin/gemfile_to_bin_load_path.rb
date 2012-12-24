#!/bin/env ruby
require 'rubygems'
require 'bundler'

puts 'bundler setup'
Bundler.setup

puts 'write out load path'
paths =Gem.loaded_specs.values.collect{ |s| File.join( s.full_gem_path, s.require_path ) }

File.open( File.join( "bin", "load_path" ), 'w' ) do |f|
  f.puts paths.join( ':' )
end
