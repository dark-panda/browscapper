# encoding: BINARY

require 'inifile'

module Browscap
  module INIReader
    class << self
      include Reader

      def load(file)
        ini = IniFile.load(file, :encoding => 'BINARY')
        ini.delete_section('GJK_Browscap_Version')

        injector = proc { |memo, section|
          unless memo[section]
            entry = UserAgent.new
            ini[section].each do |k, v|
              entry[k] = case v
                when 'false'
                  false
                when 'true'
                  true
                when /^\d+$/
                  v.to_i
                else
                  v
              end
            end
            entry.user_agent = section
            entry.pattern = pattern_to_regexp(entry.user_agent)

            memo[section] = entry

            if entry.parent
              memo = injector.call(memo, entry.parent)
              entry.merge!(memo[entry.parent])
            end
          end

          memo
        }

        ini.sections.inject({}, &injector)
      end
    end
  end
end
