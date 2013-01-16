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
require 'ixtlan/user_management/session_cuba'

module Dhammapada
  class Permissions

    def self.for( groups )
 
      # default: deny == false, actions == []
      # allow no action == deny all actions
                
      audits = Ixtlan::Guard::Permission.new( :resource => 'audits' )
      errors = Ixtlan::Guard::Permission.new( :resource => 'errors' )
      config = Ixtlan::Guard::Permission.new( :resource => 'configuration' )
      events = Ixtlan::Guard::Permission.new( :resource => 'events' )

      permissions = [ audits, errors, config ]
      
      group = groups[0]
      case group.name
      when 'root'
        # deny no action == allow all actions
        permissions.each { |p| p.deny = true }
      when 'guest'
        # deny no action == allow all actions
        audits.deny = true
      when 'admin'
        # deny no action == allow all actions
        events.actions = [ Ixtlan::Guard::Action.new( :name => :show ),
                           Ixtlan::Guard::Action.new( :name => :create,
                                                      :associations => groups.domains ),
                           Ixtlan::Guard::Action.new( :name => :updated,
                                                      :associations => groups.domains ) ,
                           Ixtlan::Guard::Action.new( :name => :destroy,
                                                      :associations => groups.domains ) ]
        events.deny = false
      when 'user'
        # allow show action on events
        events.actions = [ Ixtlan::Guard::Action.new( :name => :show ) ]
        events.deny = false
      end
      
      permissions
    end
  end
end