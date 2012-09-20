# encoding: BINARY

module Browscapper
  autoload :UserAgent,  'browscapper/user_agent'
  autoload :Reader,     'browscapper/reader'
  autoload :CSVReader,  'browscapper/reader/csv_reader'
  autoload :YAMLReader, 'browscapper/reader/yaml_reader'
  autoload :INIReader,  'browscapper/reader/ini_reader'
  autoload :MarshalReader,  'browscapper/reader/marshal_reader'

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
        else
          MarshalReader
      end

      @file = file
      @entries = reader.load(file)
      self
    end

    def dump(format = :marshal)
      @entries or Browscapper.load

      Marshal.dump(@entries)
    end

    def clear_cache
      MATCH_CACHE.clear
    end

    def matches(ua)
      @entries or self.load

      ua_str = ua.downcase
      ua_len = ua.length

      MATCH_CACHE[ua] ||= @entries.select { |k, v|
        v[:pattern] =~ ua_str if v
      }.sort_by { |(k, v)|
        ua_len - v[:user_agent].gsub(/[?*]/, '').length
      }.collect { |(k, v)|
        v
      }
    end

    def match(ua)
      if MATCH_CACHE[ua] && !MATCH_CACHE[ua].empty?
        MATCH_CACHE[ua].first
      else
        m = self.matches(ua)
        m.first if !m.empty?
      end
    end
    alias :query :match
  end
end
