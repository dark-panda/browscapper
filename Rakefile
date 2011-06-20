# -*- ruby -*-

require 'rubygems'
require 'rubygems/package_task'
require 'rake/testtask'
require 'rdoc/task'

$:.push 'lib'

version = File.read('VERSION') rescue ''

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name         = "browscap"
    gem.summary      = "A browscap.ini file reader."
    gem.description  = gem.summary
    gem.email        = "dark.panda@gmail.com"
    gem.homepage     = "http://github.com/dark-panda/browscap"
    gem.authors      = [ "J Smith" ]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

desc 'Test browscap library'
Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/**/*_tests.rb'
  t.verbose = !!ENV['VERBOSE_TESTS']
end

