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
        SQLite3::Database.close(@db)
        nil
      end

      def execute(sql, *args)
        rows = db.execute(sql, args)
        self.lastInsertRowId = SQLite3::Database.last_insert_row_id(@db)
        self.rowsAffected = SQLite3::Database.changes(@db)
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
