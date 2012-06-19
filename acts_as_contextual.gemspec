# -*- encoding: utf-8 -*-
require File.expand_path('../lib/acts_as_contextual/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tanguy Antoine"]
  gem.email         = ["antoine.tanguy35@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "acts_as_contextual"
  gem.require_paths = ["lib"]
  gem.version       = ActsAsContextual::VERSION
end
