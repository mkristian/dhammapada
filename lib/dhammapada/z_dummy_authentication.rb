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
