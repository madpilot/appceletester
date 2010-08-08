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
        @results[index]
      end

      def fieldByName(name)
        index = @results.columns.index(name)
        fieldName(index)
      end

      def fieldCount
        @results.columns
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
    end
  end
end
