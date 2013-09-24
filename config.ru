#-*- mode: ruby -*-

lib = File.expand_path( File.join( File.dirname( __FILE__ ), 'lib' ) )
$LOAD_PATH << lib unless $LOAD_PATH.member? 'lib'

require "dhammapada"

run CubaAPI

# vim: syntax=Ruby
