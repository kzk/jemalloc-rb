# -*- mode: ruby; coding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'jemalloc/version'

Gem::Specification.new do |s|
  s.name = "jemalloc"
  s.version = JEMalloc::VERSION
  s.summary = "use jemalloc as default allocator, everywhere!"
  s.description = %q{Use jemalloc as default allocator, everywhere!}
  s.author = "Kazuki Ohta"
  s.email = "kazuki.ohta@gmail.com"
  s.homepage = "https://github.com/treasure-data/jemalloc-rb"
  s.extensions = ["ext/jemalloc/extconf.rb"]

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n") 
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'bundler', ['>= 1.0.0']
  s.add_development_dependency 'rake', ['>= 0.8.7']
  s.add_development_dependency 'rake-compiler', ['~> 0.7.1']  
end
