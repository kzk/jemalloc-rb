# -*- mode: ruby; coding: utf-8 -*-                                                                                               
require 'rubygems'
require 'bundler'

require 'rake'
require 'rake/clean'
require 'rake/testtask'
require 'rubygems/package_task'

Bundler::GemHelper.install_tasks

begin
  require 'rake/extensiontask'
  Rake::ExtensionTask.new('jemalloc')
rescue LoadError
  abort "This Rakefile requires rake-compiler (gem install rake-compiler)"
end
