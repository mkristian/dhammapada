# -*- Coding: utf-8 -*-
require 'ixtlan/user_management/dummy_authentication'

if Ixtlan::UserManagement::DummyAuthentication.need_dummy?( CubaAPI[ :rest ], 'ixtlan/user_management/authentication' )

  warn '[Authentication] Using dummy Authentication'

  class Dhammapada::Authenticator 

    include Ixtlan::UserManagement::DummyAuthentication

    # def login(login, password)
    #   if ! login.blank? && password.blank?
    #     result = setup_user
    #     result.login = login.sub( /\[.*/, '' )
    #     result.name = result.login.capitalize
    #     result.groups = [ setup_group( login ) ]
    #     result
    #   end
      
    # end
    
  end
end
