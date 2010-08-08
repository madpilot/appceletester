require 'test_helper'

class TitaniumDatabaseTest < Test::Unit::TestCase
  include TestHelper
  
  def setup
    setup_context
    @filename = Titanium.resource_path + '/test.sqlite3'
  end

  def teardown
    File.unlink(@filename) if File.exists?(@filename)
    Titanium::Database.reset
  end

  def test_install
    db = @context.evaluate <<-EOF
      Ti.Database.install('test.sqlite3', 'test');
    EOF
    assert File.exists?(@filename)
    assert_equal Titanium::Database::DB, db.class
  end

  def test_install_again
    db1 = @context.evaluate <<-EOF
      Ti.Database.install('test.sqlite3', 'test');
    EOF
    db2 = @context.evaluate <<-EOF
      Ti.Database.install('test.sqlite3', 'test');
    EOF
    assert_equal db1, db2
  end

  def test_open
    db = @context.evaluate <<-EOF
      Ti.Database.open('test');
    EOF
    assert File.exists?(@filename)
    assert_equal Titanium::Database::DB, db.class
  end

  def test_open_again
    db1 = @context.evaluate <<-EOF
      Ti.Database.open('test');
    EOF
    db2 = @context.evaluate <<-EOF
      Ti.Database.open('test');
    EOF
    assert_equal db1, db2
  end
end
