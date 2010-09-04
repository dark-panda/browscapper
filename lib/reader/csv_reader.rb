
require 'reader'
begin
    require 'fastercsv'
rescue
    require 'csv'
end

module Browscap
	module CSVReader
		CSV_ENGINE = if defined?(FasterCSV)
			FasterCSV
		else
			CSV
		end

		class << self
			include Reader

			def load(file)
				csv = CSV_ENGINE.open(file, 'r')

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
					entry.user_agent.sub!(/^\[(.+)\]$/, '\1')
					entry.pattern = pattern_to_regexp(entry.user_agent)

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
