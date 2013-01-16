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
# -*- Coding: utf-8 -*-
require 'ixtlan/user_management/dummy_authentication'

if url = Ixtlan::UserManagement::DummyAuthentication.need_dummy?( CubaAPI[ :rest ], 'ixtlan/user_management/authentication' )

  warn '[Authentication] Using dummy Authentication'

  class Dhammapada::Authenticator 

    include Ixtlan::UserManagement::DummyAuthentication

  end
else

  warn "[Authentication] Using Authentication at #{CubaAPI[ :rest ].to_server('ixtlan/user_management/authentication').url}"
  
end