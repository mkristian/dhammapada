require 'ixtlan/user_management/session_cuba'
require 'ixtlan/user_management/authenticator'

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