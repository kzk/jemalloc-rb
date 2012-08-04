# -*- mode: ruby; coding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'je/version'

Gem::Specification.new do |s|
  s.name = "je"
  s.version = JE::VERSION
  s.summary = "use jemalloc as default allocator, everywhere!"
  s.description = %q{Use jemalloc as default allocator, everywhere!}
  s.author = "Kazuki Ohta"
  s.email = "kazuki.ohta@gmail.com"
  s.homepage = "http://msgpack.org/"
  s.rubyforge_project = "je"
  s.has_rdoc = true
  s.rdoc_options = ["ext"]

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n") 
  s.require_paths = ["lib"]

  s.add_development_dependency 'bundler', ['>= 1.0.0']
  s.add_development_dependency 'rake', ['>= 0.8.7']
  s.add_development_dependency 'rake-compiler', ['~> 0.7.1']  
end
