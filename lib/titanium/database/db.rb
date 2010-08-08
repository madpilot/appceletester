module Titanium
  module Database
    class DB
      attr_accessor :lastInsertRowId, :name, :rowsAffected
      
      def initialize(path, string)
        @path = path
        @name = string
        @db = SQLite3::Database.new(path)
      end

      def close
        @db.close
        Titanium::Database.send(:databases).delete_if { |k, v| k == self.name }
        nil
      end

      def execute(sql, *args)
        rows = @db.query(sql, args)
        self.lastInsertRowId = @db.last_insert_row_id
        self.rowsAffected = @db.changes
        Titanium::Database::ResultSet.new(rows)
      end

      def remove
        self.close
        File.unlink(@path)
        nil
      end
    end
  end
end
