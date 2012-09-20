# -*- ruby -*-

require 'rubygems'

gem 'rdoc', '~> 3.12'

require 'rubygems/package_task'
require 'rake/testtask'
require 'rdoc/task'
require 'bundler/gem_tasks'

if RUBY_VERSION >= '1.9'
  begin
    gem 'psych'
  rescue Exception => e
    # it's okay, fall back on the bundled psych
  end
end

$:.push 'lib'

version = Browscapper::VERSION

desc 'Test browscapper library'
Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/**/*_tests.rb']
  t.verbose = !!ENV['VERBOSE_TESTS']
  t.warning = !!ENV['WARNINGS']
end

desc 'Build docs'
Rake::RDocTask.new do |t|
  t.title = "browscapper #{version}"
  t.main = 'README.rdoc'
  t.rdoc_dir = 'doc'
  t.rdoc_files.include('README.rdoc', 'MIT-LICENSE', 'lib/**/*.rb')
end

desc "Converts a browscap file to another format"
task "browscapper:dump" do
  require File.join(File.dirname(__FILE__), %w{ lib browscapper })

  if !ENV['IN'] || !ENV['OUT']
    puts "Usage: IN=browscap OUT=browscap.dump"
    puts
    puts "Converts a browscap file to a ruby Marshal'd format. These files"
    puts "are much quicker to load than CSV or INI files."
    exit
  end

  Browscapper.load(ENV['IN'])
  File.open(ENV['OUT'], 'wb') do |fp|
    fp.write(Marshal.dump(Browscapper.entries))
  end
end
