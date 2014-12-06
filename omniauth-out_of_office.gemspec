# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omniauth-out_of_office/version"

Gem::Specification.new do |s|
  s.name        = "omniauth-out_of_office"
  s.version     = OmniAuth::OutOfOffice::VERSION
  s.authors     = ["Out of Office Travel"]
  s.email       = ["contact@outofoffice.travel"]
  s.homepage    = "https://github.com/nzaillian/omniauth-out_of_office"
  s.summary     = %q{OmniAuth strategy for OutOfOffice.travel}
  s.description = %q{OmniAuth strategy for OutOfOffice.travel}
  s.license     = "MIT"

  s.rubyforge_project = "omniauth-out_of_office"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'multi_json', '~> 1.3'
  s.add_runtime_dependency 'omniauth-oauth2'
  s.add_development_dependency 'rspec', '~> 2.7'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'webmock'
end
