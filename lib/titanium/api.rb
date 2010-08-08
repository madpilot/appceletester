module Titanium
  class API
    include Titanium
    
    def self.debug(message)
      self.log('Debug', message)
    end

    def self.error(message)
      self.log('Error', message)
    end

    def self.info(message)
      self.log('Info', message)
    end

    def self.log(level, message)
      puts "[#{level}] #{message}"
    end

    def self.warn(message)
      self.log('Warn', message)
    end
  end
end
