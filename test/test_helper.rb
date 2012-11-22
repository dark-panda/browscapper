
# encoding: BINARY

require 'rubygems'
require 'minitest/autorun'
require 'minitest/reporters'
require File.join(File.dirname(__FILE__), *%w{ .. lib browscapper })

MiniTest::Reporters.use!(MiniTest::Reporters::SpecReporter.new)

