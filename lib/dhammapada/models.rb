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
# -*- coding: utf-8 -*-

require 'virtus'

class Verse
  include Virtus

  attribute :numbers, Array[Integer]
  attribute :lines, Array[String]
end
class Chapter
  include Virtus

  attribute :number, Integer
  attribute :title, String
  attribute :verses, Array[Verse]

  def clone_for(verse)
    Chapter.new( :number => number,
                 :title => title,
                 :verses => [verse] )
  end
end
class Book
  include Virtus

  attribute :translator, String
  attribute :chapters, Array[Chapter]

  def verse( number )
    ch = chapter_of_verse_number( number )
    Book.new( :translator => translator,
              :chapters => [ ch.clone_for( verse_map[ number ] ) ] )
  end

  def chapter( number )
    Book.new( :translator => translator,
              :chapters => [ chapter_map[ number ] ] )
  end

  def number_of_verses
    verse_map.size
  end

  def to_s
    str = "#{self.class}( #{translator} "
    if chapters.size == 1
      str += "- chapter: #{chapters[0].title} " 
      str += "- verse: #{chapters[0].verses[0].numbers.join(',')} " if chapters[0].verses.size == 1
    end
    str + ")"
  end

  private

  def chapter_of_verse_number( number )
    verse_chapter_map[ number ]
  end

  def verse_map
    setup unless @verse_map
    @verse_map
  end

  def verse_chapter_map
    setup unless @verse_chapter_map
    @verse_chapter_map
  end

  def chapter_map
    setup unless @chapter_map
    @chapter_map
  end

  def setup
    @chapter_map = {}
    @verse_map = {}
    @verse_chapter_map = {}
    chapters.each do |c|
      @chapter_map[ c.number ] = c
      c.verses.each do |verse|
        verse.numbers.each do |v|
          @verse_map[ v ] = verse
          @verse_chapter_map[ v ] = c
        end
      end
    end
  end
end