# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "resque/plugins/dedup"

Gem::Specification.new do |s|
  s.name        = "resque-dedup"
  s.version     = Resque::Plugins::Dedup::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Josh Huckabee"]
  s.email       = ["joshhuckabee@gmail.com"]
  s.homepage    = "http://github.com/datagraph/resque-dedup"
  s.summary     = %q{A Resque plugin for ensuring that the same job does not get enqueued multiple times}
  s.description = %q{A Resque plugin for ensuring that the same job does not get enqueued multiple times}

  s.rubyforge_project = "resque-dedup"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
