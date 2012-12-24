# -*- coding: utf-8 -*-
require 'cuba'
require 'cuba_api'
require 'dhammapada/models'
module Dhammapada
  module Plugin

    def dhammapada( name )
      dhammapada_map[ name.sub( / /, '_').sub( /ü/, 'u').downcase ]
    end

    def dhammapada_all
      dhammapada_map.values
    end

    private

    def dhammapada_map
      @dhammapada_map ||= load
    end

    def load
      result = {}
      result[ 'john_richards' ] = load_file( "dhammapada-english-transl.yml" )
      result[ 'max_muller' ] = load_file( "dhammapada-alternate.yml" )
      result
    end

    def dir
      File.expand_path( File.join( '..', '..' ), __FILE__ )
    end

    def load_file( file )
      data = YAML.load( File.read( File.join( dir, '..', 'data', file ) ) )
      Book.new( data[ 'dhammapada' ] )
    end
  end
end
