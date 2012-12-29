# -*- coding: utf-8 -*-
require 'cuba_api'

require "rack/jsonp"
require "rack/protection"
require "securerandom"

require 'json'
require 'yaml'

# intialize application
Dir[ File.join( File.expand_path( 'dhammapada', 
                                  File.dirname( __FILE__ ) ), 
                "*.rb" ) ].sort.each do |f|
  warn "[Dhammapada] Init 'dhammapada/#{File.basename(f)}"
  require f
end

CubaAPI.use Rack::Deflater
# TODO use datamapper session
CubaAPI.use Rack::Session::Cookie, :secret => SecureRandom.hex(64)
CubaAPI.use Rack::Protection, :except => [:escaped_params,:remote_token]
#CubaAPI.use Rack::Protection::AuthenticityToken

CubaAPI.use Rack::JSONP

CubaAPI.accept :json, :yaml

CubaAPI.define do

  on 'session' do
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
