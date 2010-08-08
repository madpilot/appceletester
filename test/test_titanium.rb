require 'test_helper'

class TitaniumTest < Test::Unit::TestCase
  include TestHelper

  def setup
    setup_context
  end

  def teardown
    Titanium.reset
    @context = nil
  end

  def test_add_first_event_listener
    @context.evaluate <<-EOF
      Titanium.addEventListener('click', function(e) {
        return 'Attached';
      });
    EOF
    events = Titanium.send(:events)
    assert events.has_key?('click')
    assert events['click'].is_a?(Array)
    assert_equal 1, events['click'].length
    assert events['click'].first.is_a?(Proc)
    assert_equal 'Attached', events['click'].first.call
  end

  def test_add_second_event_listener
    @context.evaluate <<-EOF
      Titanium.addEventListener('click', function(e) {
        return 'Attached';
      });
      
      Titanium.addEventListener('click', function(e) {
        return 'Attached 2';
      });
    EOF
    
    events = Titanium.send(:events)
    assert events.has_key?('click')
    assert events['click'].is_a?(Array)
    assert_equal 2, events['click'].length
    assert events['click'].last.is_a?(Proc)
    assert_equal 'Attached 2', events['click'].last.call
  end

  def test_fire_event
    callbacks = []
    @context.global['callbacks'] = callbacks

    @context.evaluate <<-EOF
       Titanium.addEventListener('click', function(e) {
        callbacks.push('1' + e.data);
      });
      
      Titanium.addEventListener('click', function(e) {
        callbacks.push('1' + e.data);
      });

      Titanium.fireEvent('click', { data: 'a' })
    EOF

    assert 2, callbacks.length
    assert '1a', callbacks[0]
    assert '2a', callbacks[1]
  end

  def test_fire_non_existent_event
    callbacks = []
    @context.global['callbacks'] = callbacks

    @context.evaluate <<-EOF
       Titanium.addEventListener('click', function(e) {
        callbacks.push('1' + e.data);
      });
      
      Titanium.addEventListener('click', function(e) {
        callbacks.push('1' + e.data);
      });

      Titanium.fireEvent('touch', { data: 'a' })
    EOF

    assert 0, callbacks.length
  end

  def test_include
    @context.evaluate <<-EOF
      Titanium.include('include.js');
    EOF
    assert @context.evaluate("typeof IncludedLibrary != 'undefined';");
  end

  def full_test_include
    @context.evaluate <<-EOF
      Titanium.include('#{File.dirname(__FILE__)}/test/fixtures/include.js');
    EOF
    assert @context.evaluate("typeof IncludedLibrary != 'undefined';");
  end

  def test_remove_event_listener
     @context.evaluate <<-EOF
      newCallback = function(e) {
        return 'Attached 2';
      };

      Titanium.addEventListener('click', function(e) {
        return 'Attached';
      });
      
      Titanium.addEventListener('click', newCallback);
      Titanium.removeEventListener('click', newCallback);
    EOF
 
    events = Titanium.send(:events)
    assert_equal 1, events['click'].length
  end

  def test_remove_all_specific_event_listener
     @context.evaluate <<-EOF
      newCallback = function(e) {
        return 'Attached 2';
      };

      Titanium.addEventListener('click', function(e) {
        return 'Attached';
      });
      
      Titanium.addEventListener('click', newCallback);
      Titanium.removeEventListener('click');
    EOF
 
    events = Titanium.send(:events)
    assert_equal 0, events['click'].length
  end

end
