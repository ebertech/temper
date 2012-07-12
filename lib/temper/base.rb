module Temper
  class Base
    attr_accessor :original_filename
    attr_accessor :content_type

    def initialize(options = {})
      raise RuntimeException, "No @storage set" unless @storage
      self.original_filename = options[:original_filename] || ::File.basename(path)
      self.content_type = options[:content_type] || infer_content_type || "text/plain"
      
      if block_given?
        begin
          yield self
        ensure
          close
        end
      end
    end
    
    def close
      #noop
    end

    def fingerprint
      @fingerprint ||= Digest::MD5.hexdigest(self.read)
    end    

    def respond_to?(*args)
      super or @storage.respond_to?(*args)
    end

    def method_missing(method_name, *args, &block) #:nodoc:
      @storage.__send__(method_name, *args, &block)
    end

    private

    # Infer the MIME-type of the file from the extension.
    def infer_content_type
      types = MIME::Types.type_for(self.original_filename)
      if types.length == 0
        type_from_file_command
      elsif types.length == 1
        types.first.content_type
      else
        iterate_over_array_to_find_best_option(types)
      end
    end

    def iterate_over_array_to_find_best_option(types)
      types.reject {|type| type.content_type.match(/\/x-/) }.first
    end

    def type_from_file_command
      #  On BSDs, `file` doesn't give a result code of 1 if the file doesn't exist.
      type = (self.original_filename.match(/\.(\w+)$/)[1] rescue "octet-stream").downcase
      result = Shellter.run("file", "-b --mime-type :file", :file => self.path)
      result = Shellter.run("file", "-b --mime-type :file", :file => self.path) unless result.success?
      mime_type = (result.stdout.split(";").first.split(':').last.strip rescue "application/x-#{type}")
      mime_type = "application/x-#{type}" if mime_type.match(/\(.*?\)/)
      mime_type
    end
  end
end