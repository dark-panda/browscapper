# -*- encoding: utf-8 -*-

require File.expand_path('../lib/browscapper/version', __FILE__)

Gem::Specification.new do |s|
  s.name = %q{browscapper}
  s.version = Browscapper::VERSION

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["J Smith"]
  s.description = "A browscap file parser and matcher."
  s.summary = s.description
  s.email = "dark.panda@gmail.com"
  s.license = "MIT"
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = `git ls-files`.split($\)
  s.executables = s.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.homepage = "http://github.com/dark-panda/browscapper"
  s.require_paths = ["lib"]

  s.add_dependency("inifile")
end

