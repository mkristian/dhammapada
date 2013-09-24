require 'multi_json'
unless defined? JRUBY_VERSION
  # just make sure we use OJ
  MultiJson.engine= :oj
end

class Hash
  def to_json
    MultiJson.dump( self )
  end
end
