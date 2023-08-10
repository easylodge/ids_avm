# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ids_avm/version'

Gem::Specification.new do |spec|
  spec.name          = "ids_avm"
  spec.version       = IdsAvm::VERSION
  spec.authors       = ["Ekechi Ikenna"]
  spec.email         = ["ekechi.ikenna@gmail.com", "ie@easylodge.com.au", "support@easylodge.com.au"]
  spec.summary       = %q{Insight Data Solutions (IDS) Property Valuation.}
  spec.description   = %q{Rails gem for using IDS AVM public service.}
  spec.homepage      = "https://github.com/easylodge/ids_avm"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.4.12"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency 'rails', '~> 7.0.0'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'shoulda-matchers', '~> 5.0'
  spec.add_development_dependency 'pry'

  spec.add_dependency "httparty"
  spec.add_dependency 'activesupport'
end
