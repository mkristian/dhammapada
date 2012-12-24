# -*- Coding: utf-8 -*-
require "cuba"
require 'ixtlan/babel/factory'

module Ixtlan
  module Write

    module ClassMethods
      def append_aspect( arg )
        aspects << arg
        warn "[CubaAPI] Appended aspect #{arg}"
      end

      def prepend_aspect( arg )
        aspects.insert( 0, arg )
        warn "[CubaAPI] Prepended aspect #{arg}"
      end

      def aspects
        self[ :aspects ] ||= []
      end
    end

    def write( obj, args = {} )
      self.res.status = args[:status] || 200
      # make sure we inherit aspects and repsect the order
      aspects = self.class == CubaAPI ? [] : self.class.superclass[ :aspects ]
      (aspects + self.class[ :aspects ]).uniq.each { |w| obj = send( w, obj, args ) if obj }
      res.write obj.to_s
    end
  end

  module Serializer

    def serializer_factory
      @_factory ||= Ixtlan::Babel::Factory.new
    end
    private :serializer_factory

    def serializer( obj, args = {})
      if args[:serializer] == false || obj.is_a?( String )
        obj
      else
        s = serializer_factory.new( obj )
        s.use( args[ :use ] ) if args[ :use ]
        s
      end
    end

    def self.included( base )
      base.append_aspect :serializer
    end
  end

  module CurrentUser
    def current_user( user = nil )
      nil
    end

    def current_user_name
      current_user ? current_user.login : "???"
    end
  end

  module AcceptContent

    module ClassMethods

      MIMES = { :yaml => ['application/x-yaml', 'text/yaml'],
        :json => ['application/json'],
        :xml => ['application/xml'] }

      def accept( *args )
        args.each do |arg|
          (MIMES[ arg ] || []).each do |mime|
            mimes[ mime ] = "to_#{arg}".to_sym
          end
        end
        warn "[CubaAPI] Accept: #{mimes.keys.join(', ')}"
      end

      def mimes
        self[ :mimes ] ||= {}
      end
    end

    def accept_content( obj, options = {} )
      script = env[ 'SCRIPT_NAME' ]
      if script =~ /\./
        extension = script.sub( /^.*\./, '' )
        mime = ClassMethods::MIMES[ extension.to_sym ] || []
        accept( obj, mime.first )
      else
        accept( obj, env[ 'HTTP_ACCEPT' ] )
      end
    end

    def accept( obj, mime )
      if self.class[ :mimes ].key?( mime )
        res[ "Content-Type" ] = mime + "; charset=utf-8"
        obj.send self.class[ :mimes ][ mime ]
      else
        res.write ''
        res.status = 404
        nil
      end
    end
    private :accept

    def self.included( base )
      base.append_aspect :accept_content
    end
  end
end

class CubaAPI < Cuba
  def self.[]( key )
    settings[ key ] || (superclass == Cuba ? Cuba.settings[ key ] : superclass[ key ])
  end

  def self.[]=( key, value )
    settings[ key ] = value
  end

  plugin Ixtlan::Write
  plugin Ixtlan::Serializer
  plugin Ixtlan::AcceptContent
  plugin Ixtlan::CurrentUser
end
