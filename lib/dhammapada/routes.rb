# -*- coding: utf-8 -*-
require 'cuba_api'
require 'dhammapada/app'

module Dhammapada
  class Cuba < CubaAPI

    plugin App

    define do
      on 'random' do
        write random_verse
      end
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
