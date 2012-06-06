# -*- encoding: utf-8 -*-
require File.expand_path('../lib/temper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andrew Eberbach"]
  gem.email         = ["andrew@ebertech.ca"]
  gem.description   = %q{A gem for a slightly smarter temporary file and temporary directory maintenance}
  gem.summary       = %q{Combines the best parts of Upfile from paperclip and Rack::Multipart::UploadedFile from rack.}
  gem.homepage      = "https://github.com/ebertech/temper"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "temper"
  gem.require_paths = ["lib"]
  gem.version       = Temper::VERSION
  
  gem.add_runtime_dependency "mime-types"
  gem.add_runtime_dependency "cocaine"
  
  gem.add_development_dependency "rspec", "> 2.0"
end
