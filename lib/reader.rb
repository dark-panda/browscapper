
module Browscap
	module Reader
		def pattern_to_regexp(pattern)
			Regexp.new(
				'^' +
				pattern.downcase.
					gsub(%r{\\}, '\\').
					gsub(/\./, '\.').
					gsub(/\?/, '.').
					gsub(/\*/, '.*').
					gsub(/\(/, '\(').
					gsub(/\)/, '\)') +
				'$'
			)
		end
	end
end
