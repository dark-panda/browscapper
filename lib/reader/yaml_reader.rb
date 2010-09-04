
require 'reader'
require 'yaml'

module Browscap
	module YAMLReader
		class << self
			def load(file)
				YAML.load(File.open(file, 'r'))
			end
		end
	end
end
