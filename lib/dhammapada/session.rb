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
