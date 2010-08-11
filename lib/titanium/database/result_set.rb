module Titanium
  module Database
    class ResultSet
      attr_accessor :rowCount, :validRow
      
      def initialize(results)
        @results = results
      end

      def close
        @results.close
        nil
      end

      def field(index)
        current[index]
      end

      def fieldByName(name)
        index = @results.columns.index(name)
        field(index)
      end

      def fieldCount
        @results.columns.size
      end

      def fieldName(index)
        @results.columns[index]
      end

      def isValidRow
        !@results.eof?
      end

      def next
        @results.next || false
      end

    protected
      def current
        @current ||= @results.next
      end
    end
  end
end
