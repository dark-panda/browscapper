
module Browscap
  autoload :UserAgent,  'browscap/user_agent'
  autoload :Reader,     'browscap/reader'
  autoload :CSVReader,  'browscap/reader/csv_reader'
  autoload :YAMLReader, 'browscap/reader/yaml_reader'
  autoload :INIReader,  'browscap/reader/ini_reader'

  class << self
    attr_reader :entries, :file
    MATCH_CACHE = Hash.new

    def load(file = File.join(%w{ . browscap.ini }))
      reader = case file.downcase
        when /\.csv$/
          CSVReader
        when /\.ya?ml$/
          YAMLReader
        when /\.ini$/
          INIReader
      end

      @file = file
      @entries = reader.load(file)
      self
    end

    def clear_cache
      MATCH_CACHE.clear
    end

    def matches(ua)
      @entries or self.load

      ua_str = ua.downcase
      ua_len = ua.length
      MATCH_CACHE[ua] ||= @entries.select { |(k, v)|
        v[:pattern] =~ ua_str
      }.sort_by { |(k, v)|
        ua_len - v[:user_agent].gsub(/[?*]/, '').length
      }.collect { |(k, v)|
        v
      }
    end

    def match(ua)
      m = self.matches(ua)
      m.first if !m.empty?
    end
  end
end
