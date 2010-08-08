require 'sqlite3'
module Titanium
  module Database
    include Titanium
    def self.install(path, string)
      return databases[string] if databases.has_key?[string]
      databases[string] = Titanium::Database::Db.new(path, string)
    end

    def self.open(name)
      self.install("#{name}.sqlite", name)
    end

  protected
    def databases
      @databases ||= {}
    end
  end
end
