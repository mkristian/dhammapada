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
