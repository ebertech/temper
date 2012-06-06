module Temper
  class File < Base
    def initialize(options = {})      
      options ||= {}
      @storage = setup_storage(options)
      path = options[:content]
      if path && ::File.exists?(path)
        options[:original_filename] ||= ::File.basename(path) 
      end
      super options
    end
    
    private 
    
    def setup_storage(options = {})
      path = options[:content]
      raise ArgumentError, "#{path} file does not exist" if path && !::File.exist?(path)
      Tempfile.new("temperfi").tap do |tempfile|
        tempfile.set_encoding(Encoding::BINARY) if tempfile.respond_to?(:set_encoding)
        tempfile.binmode unless options.key?(:binary) && !options[:binary]
        if path
          ::File.open(path, "rb") do |f|
            tempfile.write(f.read)
            tempfile.flush
            tempfile.rewind
          end
        end
      end
    end
  end
end