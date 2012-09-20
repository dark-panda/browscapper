# encoding: BINARY

module Browscap
  module MarshalReader
    class << self
      include Reader

      def load(file)
        Marshal.load(File.open(file, 'rb').read)
      end
    end
  end
end
