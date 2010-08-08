module Titanium
  module Api
    class Properties
      include Titanium
      
      def self.getBool(property, default)
        self.getProperty(property, default)
      end

      def self.getDouble(property, default)
        self.getProperty(property, default)
      end

      def self.getInt(property, default)
        self.getProperty(property, default)
      end

      def self.getList(property, default)
        self.getProperty(property, default)
      end

      def self.getString(property, default)
        self.getProperty(property, default)
      end

      def self.hasProperty(property)
        properties.has_key?(property)
      end

      def self.listProperties
        properties.keys
      end

      def self.setBool(property, value)
        self.setProperty(property, value)
      end

      def self.setDouble(property, value)
        self.setProperty(property, value)
      end

      def self.setInt(property, value)
        self.setProperty(property, value)
      end

      def self.seList(property, value)
        self.setProperty(property, value)
      end

      def self.setString(property, value)
        self.setProperty(property, value)
      end

    protected
      def self.properties
        @properties ||= {}
      end

      def self.getProperty(property, default)
        self.hasProperty(property) ? properties[property] : default
      end

      def self.setProperty(property, value)
        properties[property] = value
      end
    end
  end
end
