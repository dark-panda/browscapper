# encoding: BINARY

if RUBY_VERSION.to_f < 1.9
  require 'fastercsv'
else
  require 'csv'
end

module Browscapper
  module CSVReader
    CSV_ENGINE = if defined?(FasterCSV)
      FasterCSV
    else
      CSV
    end

    class << self
      include Reader

      def load(file)
        csv = CSV_ENGINE.open(file, 'rb')

        # skip header
        2.times { csv.shift }
        headers = csv.shift

        entries = Hash.new

        csv.each do |l|
          entry = UserAgent.new
          headers.each_with_index do |v, i|
            entry[v] = case l[i]
              when 'false'
                false
              when 'true'
                true
              when /^\d+$/
                l[i].to_i
              else
                l[i]
            end
          end

          entry.user_agent = if entry.user_agent
            entry.user_agent.sub!(/^\[(.+)\]$/, '\1')
          elsif entry.browser
            entry.browser
          end

          entry.pattern = pattern_to_regexp(entry.user_agent.to_s)

          if entries[entry.parent]
            entry.merge!(entries[entry.parent])
          end

          entries[entry.user_agent] = entry
        end

        entries
      end
    end
  end
end
