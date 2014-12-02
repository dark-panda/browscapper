
# encoding: BINARY

if RUBY_VERSION >= '1.9'
  require 'simplecov'

  SimpleCov.command_name('Unit Tests')
  SimpleCov.start do
    add_filter '/test/'
  end
end

require 'rubygems'
require 'minitest/autorun'

if RUBY_VERSION >= '1.9'
  require 'minitest/reporters'
end

require File.join(File.dirname(__FILE__), *%w{ .. lib browscapper })

if RUBY_VERSION >= '1.9'
  MiniTest::Reporters.use!(MiniTest::Reporters::SpecReporter.new)
end

Browscapper.load(File.join('vendor', 'browscap.ini'))
