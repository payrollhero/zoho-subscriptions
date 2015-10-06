# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zoho/subscriptions/version'

Gem::Specification.new do |spec|
  spec.name          = "zoho-subscriptions"
  spec.version       = Zoho::Subscriptions::VERSION
  spec.authors       = ["Ronald Maravilla"]
  spec.email         = ["rmaravilla@payrollhero.com"]

  spec.summary       = %q{A Zoho Subscription API Client.}
  spec.description   = %q{A Zoho Subscription API Client.}
  spec.homepage      = "https://github.com/payrollhero/zoho-subscriptions"
  spec.license       = "BSD-3-Clause"


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "sinatra"

  spec.add_dependency "activesupport"
  spec.add_dependency "activemodel"
  spec.add_dependency "httparty"
end
