# -*- coding: utf-8 -*-
require 'cuba'
require 'cuba_api'
require 'dhammapada/plugin'

module Dhammapada
  class Cuba < CubaAPI

    plugin Plugin

    define do
      on ":name" do |name|
        on get, "chapter/:number" do |number|
          write dhammapada( name ).chapter( number.to_i )
        end

        on get, "verse/:number" do |number|
          write dhammapada( name ).verse( number.to_i )
        end

        on get do
          write dhammapada( name.sub( /\..*$/, '') )
        end
      end

      on get do
        write dhammapada_all
      end
    end

  end
end
