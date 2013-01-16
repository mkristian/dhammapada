# -*- coding: utf-8 -*-

#require 'ixtlan-babel'

require 'ixtlan/babel/serializer'

class BookSerializer < Ixtlan::Babel::Serializer

  root 'dhammapada'

  add_context( :single,
               :include => {
                 :chapters => {
                   :include => {
                     :verses => {
                       :include => [ :lines, :numbers ] 
                     }
                   }
                 }
               })
  add_context( :collection,
               :include => {
                 :chapters => {
                   :include => {
                     :verses => {
                       :include => [ :lines, :numbers ] 
                     }
                   }
                 }
               })
end
