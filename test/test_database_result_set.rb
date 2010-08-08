require 'test_helper'
require 'fileutils'

class TitaniumDatabaseResultSetTest < Test::Unit::TestCase
  include TestHelper
  
  def setup
    setup_context
    FileUtils.cp(File.join(File.dirname(__FILE__), 'fixtures', 'test.sqlite3'), Titanium.resource_path + '/test.sqlite3')
    @filename = Titanium.resource_path + '/test.sqlite3'

    
    @db = SQLite3::Database.new(@filename)
    @db.execute("INSERT INTO test (name) VALUES ('Myles')")
    @db.execute("INSERT INTO test (name) VALUES ('Sam')")
    @raw_set = @db.query('SELECT * FROM test')
    @result_set = Titanium::Database::ResultSet.new(@raw_set)
  end

  def teardown
    File.unlink(@filename) if File.exists?(@filename)
    Titanium::Database.reset
  end

  def test_close
    @result_set.close
    assert @raw_set.closed?
  end

  def test_field
    assert_equal 'Myles', @result_set.field(0)
  end

  def test_next
    assert @result_set.next != false
    assert @result_set.next != false
    assert @result_set.next === false
  end

  def test_is_valid_row
    assert @result_set.isValidRow
    @result_set.next
    assert @result_set.isValidRow
    @result_set.next
    assert @result_set.isValidRow
    @result_set.next
    assert !@result_set.isValidRow
  end
end
