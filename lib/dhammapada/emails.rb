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
require 'pony'

if ENV[ 'SENDGRID_USERNAME' ]
  Pony.options = {
    :via         => :smtp,
    :via_options => {
      :address        => 'smtp.sendgrid.net',
      :port           => '587',
      :authentication => :plain,
      :user_name      => ENV[ 'SENDGRID_USERNAME' ],
      :password       => ENV[ 'SENDGRID_PASSWORD' ],
      :domain         => 'heroku.com'
    }
  }
else
  class MailDump
    def initialize( values )
      @settings = {}
    end
    
    attr_accessor :settings

    def deliver!( mail )
      puts mail.to_s
    end
  end
  Pony.options = { :via => MailDump }
end