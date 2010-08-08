require 'johnson/tracemonkey'

require 'lib/titanium/api'
require 'lib/titanium/accelerometer'
require 'lib/titanium/analytics'
require 'lib/titanium/app'
require 'lib/titanium/app/properties'

require 'lib/titanium/database'
require 'lib/titanium/database/db'
require 'lib/titanium/database/result_set'

module Titanium
  def self.context
    @context
  end

  def self.context=(context)
    @context = context
  end

  def self.resource_path
    @resource_path
  end

  def self.resource_path=(path)
    @resource_path = path
  end

  def self.addEventListener(name, &lambda)
    self.events[name] ||= []
    self.events[name] << lambda
    nil
  end

  def self.fireEvent(name, event)
    self.events[name].each { |e| e.call(event) } if self.events.has_key?(name)
    nil
  end

  def self.include(name)
    name = resource_path + "/" + name unless name[0..0] == "/"
    script = ''
    File.open(name, 'r') do |fh|
      script = fh.read
    end
    @context.evaluate(script)
  end

  def self.removeEventListener(name, &lambda)
    if block_given?
      events[name] = events[name].delete_if { |e| e == lambda }
    else
      events[name] = []
    end
    nil
  end

  def self.reset
    @events = {}
  end
protected
  def self.events
    @events ||= {}
  end
end
