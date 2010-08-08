module Titanium
  module Database
    require 'sqlite3'
    include Titanium
    
    def self.install(path, string)
      path = Titanium.resource_path + "/" + path unless path[0..0] == '/'
      return databases[string] if databases.has_key?(string)
      databases[string] = Database::DB.new(path, string)
    end

    def self.open(name)
      self.install("#{name}.sqlite3", name)
    end

    def self.reset
      @databases = {}
    end
  protected
    def self.databases
      @databases ||= {}
    end
  end
end
