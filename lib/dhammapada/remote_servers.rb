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
require 'ixtlan/user_management/authentication_model'
require 'ixtlan/user_management/user_resource'
require 'ixtlan/remote/rest'

CubaAPI[ :rest ] = Ixtlan::Remote::Rest.new
CubaAPI[ :rest ].server( :users ) do |server|
  users_config = Ixtlan::Passwords.get( :rest ).get( :users )
  server.url = users_config.get( :url, "http://localhost:3000" )
  server.options[ :headers ] = {'X-Service-Token' => users_config.get( :token, 'behappy' )}
  server.add_model( Ixtlan::UserManagement::Authentication, :authentications )
  server.add_model( Ixtlan::UserManagement::User, :users )
end