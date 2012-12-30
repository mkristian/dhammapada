require 'ixtlan/user_management/authentication_model'
require 'ixtlan/remote/rest'

CubaAPI[ :rest ] = Ixtlan::Remote::Rest.new
CubaAPI[ :rest ].server( :users ) do |server|
  users_config = Ixtlan::Passwords.get( :rest ).get( :users )
  server.url = users_config.get( :url, "http://localhost:3000" )
  server.options[ :headers ] = {'X-Service-Token' => users_config.get( :token, 'behappy' )}
  server.add_model( Ixtlan::UserManagement::Authentication, :authentications )
end
