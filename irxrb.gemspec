# -*- encoding: utf-8 -*-
require File.expand_path('../lib/irxrb/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["irxground"]
  gem.email         = ["irxnjhtchlnrw@gmail.com"]
  gem.description   = %q{Ruby extension}
  gem.summary       = %q{Ruby extension}
  gem.homepage      = "https://github.com/irxground/irxrb"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "irxrb"
  gem.require_paths = ["lib"]
  gem.version       = Irxrb::VERSION
end
