module Temper
  class StringIO < Base
    def initialize(options = {})
      @storage = ::StringIO.new(options[:content].to_s)
      options[:original_filename] ||= "stringio.txt"
      super options.merge(options)
    end
  end
end