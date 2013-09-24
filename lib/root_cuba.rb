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

require 'cuba_api/reloader_rack'
require 'cuba_api/ext2mime_rack'
require 'cuba_api/utils'
require 'cuba_api/cors'

require "rack/protection"
require 'rack/csrf'
require 'encrypted_cookie'

require 'json'
require 'yaml'

require 'dhammapada/cuba'

# assume that when we use dummy-authentication that we also want reloading
if defined? Ixtlan::UserManagement::DummyAuthentication
  CubaAPI.use CubaApi::ReloaderRack, 'lib/4foodiez', ForFoodiez
end

CubaAPI.use Rack::Session::EncryptedCookie, :secret => Ixtlan::Configuration::Configuration.instance.encrypted_cookie_secret
CubaAPI.use Rack::Csrf, :skip => [ 'POST:/session.*', 'DELETE:/session' ]
CubaAPI.use Rack::ConditionalGet
CubaAPI.use Rack::ETag
# jruby rack-filter does not behave with gzip streams
CubaAPI.use Rack::Deflater unless defined? JRUBY_VERSION
CubaAPI.use Rack::Protection, :except => [:escaped_params,:remote_token, :http_origin]
CubaAPI.use CubaApi::Ext2MimeRack, 'json', 'yaml'

CubaAPI.accept :json, :yaml

CubaAPI.plugin CubaApi::Utils
CubaAPI.plugin CubaApi::Cors
CubaAPI.cors_setup do |cors|
  cors.origins = '*'
end

CubaAPI.define do

  on 'session' do
    Rack::Csrf.csrf_token( env )
    run Ixtlan::UserManagement::SessionCuba
  end

  # audits API for system backend
  on 'audits' do
    on authenticated?, allowed?( 'admin', 'root' ) do
      run Ixtlan::Audit::Cuba
    end

    on default do
      head :unauthorized # 401
    end
  end

  # errors API for system backend
  on 'errors' do
    on authenticated?, allowed?( 'root' ) do
      run Ixtlan::Errors::Cuba
    end

    on default do
      head :unauthorized # 401
    end
  end

  # configuration API for system backend
  on 'configuration' do
    on authenticated?, allowed?( 'root' ) do
        run Ixtlan::Configuration::Cuba
    end

    on default do
      head :unauthorized # 401
    end
  end

  on "dhammapada" do
    run Dhammapada::Cuba
  end
end
