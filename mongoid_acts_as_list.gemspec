# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "acts_as_list/version"

Gem::Specification.new do |s|
  
  s.name = 'acts_as_list'
  s.version = ActsAsList::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['redfield', 'Tyralion']
  s.email = ['info@dancingbytes.ru']
  s.homepage = 'https://github.com/dancingbytes/acts_as_list'
  s.summary = 'Files upload manager for rails'
  s.description = 'Files upload manager for rails'

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.extra_rdoc_files = ['README']
  s.require_paths = ['lib']

  s.licenses = ['MIT']

  s.add_dependency 'railties', ['>= 3.0.0']
  
end
