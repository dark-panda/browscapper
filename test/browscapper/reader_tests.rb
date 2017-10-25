# frozen_string_literal: true
# encoding: BINARY

$: << File.dirname(__FILE__)
require 'test_helper'
require 'benchmark'

class Browscapper::ReaderTests < Minitest::Test
  include Browscapper::Reader

  def test_pattern_to_regexp
    assert_equal(
      /^mozilla\/5\.0 \(foo.*?\) \+http:\/\/example\.com chrome.*?\/..$/,
      pattern_to_regexp("Mozilla/5.0 (Foo*) +http://example.com Chrome*/??")
    )
  end

  if ENV['BENCH']
    def test_csv
      Benchmark.bmbm do |bmbm|
        bmbm.report('csv') do
          Browscapper.load('vendor/browscap.csv')
        end
      end
    end

    def test_yaml
      Benchmark.bmbm do |bmbm|
        bmbm.report('yaml') do
          Browscapper.load('vendor/browscap.yml')
        end
      end
    end

    def test_ini
      Benchmark.bmbm do |bmbm|
        bmbm.report('ini') do
          Browscapper.load('vendor/browscap.ini')
        end
      end
    end

    def test_marshal
      Benchmark.bmbm do |bmbm|
        bmbm.report('marshal') do
          Browscapper.load('vendor/browscap.dump')
        end
      end
    end
  end
end

