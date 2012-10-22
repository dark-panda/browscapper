
# encoding: BINARY

require 'rubygems'
require 'minitest/autorun'
require 'turn/autorun'
require File.join(File.dirname(__FILE__), *%w{ .. lib browscapper })

if ENV['autotest']
  module Turn::Colorize
    def self.color_supported?
      true
    end
  end
end

