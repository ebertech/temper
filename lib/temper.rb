require 'tempfile'
require 'stringio'
require 'mime/types'

module Temper
  autoload :Base, 'temper/base'
  autoload :File, 'temper/file'
  autoload :StringIO, 'temper/stringio'  
  autoload :VERSION, 'temper/version'
  
  Fi = File unless defined?(Fi)
  Si = StringIO unless defined?(Si)
end