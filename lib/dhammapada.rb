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

require "rack/jsonp"
require "rack/protection"
require 'rack/csrf'
require "securerandom"

require 'json'
require 'yaml'

require 'dm-migrations'
require 'dm-validations'
require 'dm-aggregates'

# intialize application
Dir[ File.join( File.expand_path( 'dhammapada', 
                                  File.dirname( __FILE__ ) ), 
                "*.rb" ) ].sort.each do |f|
  warn "[Dhammapada] Init 'dhammapada/#{File.basename(f)}'"
  require f
end

CubaAPI.use Rack::Session::Cookie, :secret => Ixtlan::Passwords.get( :security_token, "something" )
CubaAPI.use Rack::Protection, :except => [:escaped_params,:remote_token]
CubaAPI.use Rack::Csrf, :skip => ['POST:/session.*', 'DELETE:/session']
CubaAPI.use Rack::JSONP
CubaAPI.use Rack::Deflater

CubaAPI.accept :json, :yaml

CubaAPI.define do

  on 'session' do
    Rack::Csrf.csrf_token( env )
    run Ixtlan::UserManagement::SessionCuba
  end

  on authenticated? do
    on 'audits', allowed?( 'guest', 'root' ) do
      run Ixtlan::Audit::Cuba
    end
    on 'errors', allowed?( 'root' ) do
      run Ixtlan::Errors::Cuba
    end
  end

  on "dhammapada" do
    run Dhammapada::Cuba
  end
end