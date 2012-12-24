$LOAD_PATH << 'lib' unless $LOAD_PATH.member? 'lib'

require "dhammapada"

run CubaAPI
