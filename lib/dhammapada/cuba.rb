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
# -*- coding: utf-8 -*-
require 'cuba_api'
require 'dhammapada/app'
require 'dhammapada/serializers'

module Dhammapada
  class Cuba < CubaAPI

    plugin App

    define do

      on_cors_method [ :get, :head, :put ] do

        on head do
          last_modified( last_modified_max )
          res.status = 200
        end

        on /random/ do
          write random_verse
        end

        on ":name" do |name|
          on "chapter/:number" do |number|
            if modified_since.nil? || modified_since < last_modified_max
              last_modified( last_modified_max )
              write dhammapada( name ).chapter( number.to_i )
            else
              last_modified( modified_since )            
            end
          end
          
          on "verse/:number" do |number|
            if modified_since.nil? || modified_since < last_modified_max
              last_modified( last_modified_max )
              write dhammapada( name ).verse( number.to_i )
            else
              last_modified( modified_since )            
            end
          end
          
          on no_path do
            if modified_since.nil? || modified_since < last_modified_max
              last_modified( last_modified_max )
              write dhammapada( name.sub( /\..*$/, '') )
            else
              last_modified( modified_since )            
            end
          end
        end

        on no_path do
          if modified_since.nil? || modified_since < last_modified_max
            last_modified( last_modified_max )
            write dhammapada_all
          else
            last_modified( modified_since )            
          end
        end
      end
    end
  end
end
