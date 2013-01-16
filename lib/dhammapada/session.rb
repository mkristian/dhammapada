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
require 'ixtlan/user_management/session_cuba'
require 'ixtlan/user_management/authenticator'
require 'ixtlan/user_management/user_resource'
require 'ixtlan/guard/models'
require 'ixtlan/user_management/session_manager'

module Dhammapada
  class Authenticator < Ixtlan::UserManagement::Authenticator 
  
    def setup_user
      Ixtlan::UserManagement::User.new
    end

  end
end

# setup session cuba to use this authenticator
Ixtlan::UserManagement::SessionCuba[ :authenticator ] = Dhammapada::Authenticator.new( CubaAPI[ :rest ] )

CubaAPI[ :sessions ] = Ixtlan::UserManagement::SessionManager.new do |groups|
  Dhammapada::Permissions.for( groups )
end