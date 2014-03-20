# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hijinks/version'

Gem::Specification.new do |spec|
  spec.name          = "hijinks"
  spec.version       = Hijinks::VERSION
  spec.authors       = ["Dirk Gadsden"]
  spec.email         = ["dirk@dirk.to"]
  spec.summary       = %q{JavaScript on Hivm}
  spec.description   = %q{Experimental JavaScript engine running on the Hivm virtual machine}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "twostroke", "~> 0.2.3"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
