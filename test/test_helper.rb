$: << File.join(File.dirname(__FILE__), '..')

require 'test/unit'
require 'mocha'
require 'lib/titanium'
require 'redgreen'

module TestHelper
  def setup_context
    @context = Johnson::Runtime.new
    Titanium.context = @context
    Titanium.resource_path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'test', 'Resources'))
    @context.global['Titanium'] = Titanium
    @context.global['Ti'] = Titanium
  end
end
