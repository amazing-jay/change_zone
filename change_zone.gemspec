# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "change_zone/version"

Gem::Specification.new do |s|
  s.name        = "change_zone"
  s.version     = ChangeZone::VERSION
  s.authors     = ["Jay Crouch"]
  s.email       = ["jay.crouch@me.com"]
  s.homepage    = "http://rubygems.org/gems/change_zone"
  s.summary     = %q{Extends Time and TimeWithZone Classes with change_zone(ZONE) and change :zone => ZONE functionality }
  s.description = %q{Extends Time and TimeWithZone Classes with change_zone(ZONE) and change :zone => ZONE functionality }

  s.rubyforge_project = "change_zone"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'rails'
end
