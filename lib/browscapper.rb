# encoding: BINARY

require 'browscapper/version'

module Browscapper
  autoload :UserAgent,  'browscapper/user_agent'
  autoload :Reader,     'browscapper/reader'
  autoload :CSVReader,  'browscapper/reader/csv_reader'
  autoload :YAMLReader, 'browscapper/reader/yaml_reader'
  autoload :INIReader,  'browscapper/reader/ini_reader'
  autoload :MarshalReader,  'browscapper/reader/marshal_reader'

  class Error < RuntimeError
  end

  class NotLoadedError < Error
    def initialize
      super("Browscap file not loaded")
    end
  end

  class << self
    attr_reader :entries, :file
    MATCH_CACHE = Hash.new

    def load(file = File.join(%w{ . browscap.ini }))
      if !File.exists?(file)
        raise ArgumentError.new("File #{file} not found.")
      end

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
      clear_cache
      self
    end

    def clear_cache
      MATCH_CACHE.clear
    end

    def matches(ua)
      return nil if ua_empty?(ua)

      @entries or self.load

      ua_str = ua.to_s.downcase
      ua_len = ua_str.length

      MATCH_CACHE[ua] ||= @entries.select { |k, v|
        v[:pattern] =~ ua_str if v
      }.sort_by { |(k, v)|
        ua_len - v[:user_agent].gsub(/[?*]/, '').length
      }.collect { |(k, v)|
        v
      }
    end

    def match(ua)
      return nil if ua_empty?(ua)

      if MATCH_CACHE[ua] && !MATCH_CACHE[ua].empty?
        MATCH_CACHE[ua].first
      else
        m = self.matches(ua)
        m.first if !m.empty?
      end
    end
    alias :query :match

    def browscap_version
      raise Browscapper::NotLoadedError.new if entries.nil?

      if entries[:browscap_version] && entries[:browscap_version][:version]
        entries[:browscap_version][:version]
      end
    end

    def browscap_released
      raise Browscapper::NotLoadedError.new if entries.nil?

      if entries[:browscap_version] && entries[:browscap_version][:released]
        Date.parse(entries[:browscap_version][:released])
      end
    end

    def browscap_format
      raise Browscapper::NotLoadedError.new if entries.nil?

      if entries[:browscap_version] && entries[:browscap_version][:format]
        entries[:browscap_version][:format]
      end
    end

    def browscap_type
      raise Browscapper::NotLoadedError.new if entries.nil?

      if entries[:browscap_version] && entries[:browscap_version][:type]
        entries[:browscap_version][:type]
      end
    end

    private
      def ua_empty?(ua)
        return true if ua.nil?
        return true if ua.respond_to?(:empty) && ua.empty?

        false
      end
  end
end
