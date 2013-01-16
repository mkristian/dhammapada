# -*- coding: utf-8 -*-
#
# dhammapada app - webapp to browse and display two translations of the
# Dhammapada.
# Copyright (C) 2013 Christian Meier
#
# This file is part of dhammapada app.
#
# dhammapada app is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# dhammapada app is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with dhammapada app.  If not, see <http://www.gnu.org/licenses/>.
#
require 'securerandom'
require 'dhammapada/models'
module Dhammapada
  module App

    def dhammapada( name )
      dhammapada_map[ name.sub( / /, '_').sub( /ü/, 'u').downcase ]
    end

    def random_verse
      d = dhammapada_map[ dhammapada_map.keys[ SecureRandom.random_number(2) ] ]
      d.verse( SecureRandom.random_number( d.number_of_verses ) )
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
