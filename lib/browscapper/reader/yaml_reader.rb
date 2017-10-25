# frozen_string_literal: true
# encoding: BINARY

require 'yaml'

module Browscapper
  module YAMLReader
    class << self
      def load(file)
        YAML.load(File.open(file, 'rb'))
      end
    end
  end
end
