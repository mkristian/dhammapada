#!/bin/ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'yaml'

require File.expand_path( 'models.rb' )

{ 'dhammapada-alternate' => "F. Max Müller",
'dhammapada-english-transl' => 'John Richards' }.each do |file, name|

  lines = File.read( "#{file}.txt" ).split( /\n/ )

  result = Dhammapada.new( :translator => name )
  result.chapters = []
  current_chapter = nil
  current_verse = nil
  lines.each do |l|
    l.strip!
    if l =~ /^[0-9][0-9]?\./
      current_chapter = Chapter.new
      current_chapter.number = l.sub /\..*$/, ''
      current_chapter.title = l.sub /^.*[0-9]+\.\s+/, ''
      current_chapter.verses = []
      current_verse = nil
      result.chapters << current_chapter
    end
    if current_chapter && ! l.empty? && current_verse
      if l =~ /[0-9, ]*[0-9]$/
        current_verse.lines << l.sub( /[0-9, ]*[0-9]$/, '' )
        current_verse.numbers = l.sub( /^[^0-9]+\ /, '' ).split( /,\s/ )
        current_chapter.verses << current_verse
        current_verse = nil
      else
        current_verse.lines << l
      end
    end
    if current_chapter && current_verse.nil?
      current_verse = Verse.new
      current_verse.lines = []
    end

  end

  # result.chapters.each { |c| p c.title + " #{c.verses.size}" }

  # p result.chapters.last.verses.last

  # p result.chapters.first.verses.first


  # p result.verse 227
  # p result.verse 228
  # p result.verse 229
  # p result.verse 230
  # p result.verse 231

  # p result.verse 2

  #p result.verses
  #p ( (1..423).collect{ |c| c } - result.verses )
  #p result.verses.size
  File.open( "#{file}.yml", 'w' ){|f| f.puts DhammapadaSerializer.new( result ).to_yaml }

  dp = Dhammapada.new( YAML.load(File.read("#{file}.yml")))

puts DhammapadaSerializer.new( dp ).to_yaml
puts file
puts dp == result
  puts DhammapadaSerializer.new( dp ).to_hash ==  DhammapadaSerializer.new(result).to_hash

end

