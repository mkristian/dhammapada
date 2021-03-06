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
# TODO remove that needed require
require 'ixtlan/guard/models'

require 'ixtlan/errors/rack'
require 'ixtlan/errors/resource'
require 'ixtlan/errors/dumper'
require 'ixtlan/errors/cuba'

CubaAPI.use( Ixtlan::Errors::Rack, Ixtlan::Errors::Dumper.new do |dumper|
               c = Ixtlan::Configuration::Configuration.instance
               dumper.from_email = c.errors_from_email
               dumper.to_emails = c.errors_to_emails
               dumper.keep_dumps = c.errors_keep_dumps
               dumper.base_url = c.errors_base_url
             end )
