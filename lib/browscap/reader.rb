# encoding: BINARY

module Browscap
  module Reader
    def pattern_to_regexp(pattern)
      pattern = pattern.dup

      if pattern.respond_to?(:force_encoding)
        pattern.force_encoding('BINARY')
      end

      pattern.downcase!
      pattern.gsub!(/([\^\$\(\)\[\]\.\-])/, "\\\\\\1")
      pattern.gsub!('?', '.')
      pattern.gsub!('*', '.*?')

      Regexp.new("^#{pattern}$")
    end
  end
end
