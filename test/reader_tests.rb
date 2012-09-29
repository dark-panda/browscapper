
# encoding: BINARY

$: << './lib'

require 'rubygems'
require 'minitest/autorun'
require 'minitest/benchmark' if ENV['BENCH']
require './lib/browscapper'
require 'benchmark'

class ReaderTests < MiniTest::Unit::TestCase
  def bench_csv
    assert_performance_constant do |n|
      Browscapper.load('vendor/browscap.csv')
    end
  end

  def bench_yaml
    assert_performance_constant do |n|
      Browscapper.load('vendor/browscap.yml')
    end
  end

  def bench_ini
    assert_performance_constant do |n|
      Browscapper.load('vendor/browscap.ini')
    end
  end

  def bench_marshal
    assert_performance_constant do |n|
      Browscapper.load('vendor/browscap.dump')
    end
  end
end

