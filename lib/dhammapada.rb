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
CubaAPI.use Rack::Session::Cookie, :secret => SecureRandom.hex(64)
CubaAPI.use Rack::Protection
CubaAPI.use Rack::JSONP

CubaAPI.accept :json, :yaml

CubaAPI.define do
  on 'audits' do
    run Ixtlan::Audit::Cuba
  end
  on 'errors' do
    run Ixtlan::Errors::Cuba
  end
  on "dhammapada" do
    run Dhammapada::Cuba
  end
end
