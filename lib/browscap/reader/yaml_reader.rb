# encoding: BINARY

require 'yaml'

module Browscap
  module YAMLReader
    class << self
      def load(file)
        YAML.load(File.open(file, 'rb'))
      end
    end
  end
end
