# encoding: BINARY

module Browscap
  module Reader
    def pattern_to_regexp(pattern)
      if pattern.respond_to?(:force_encoding)
        pattern = pattern.dup
        pattern.force_encoding('BINARY')
      end

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
