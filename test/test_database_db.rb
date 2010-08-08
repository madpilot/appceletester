require 'test_helper'
require 'fileutils'

class TitaniumDatabaseTest < Test::Unit::TestCase
  include TestHelper
  
  def setup
    setup_context
    FileUtils.cp(File.join(File.dirname(__FILE__), 'fixtures', 'test.sqlite3'), Titanium.resource_path + '/test.sqlite3')
    @filename = Titanium.resource_path + '/test.sqlite3'
    @db = Titanium::Database.install('test.sqlite3', 'test')
  end

  def teardown
    File.unlink(@filename) if File.exists?(@filename)
    Titanium::Database.reset
  end

  def test_new
    File.unlink(@filename) if File.exists?(@filename)
    Titanium::Database.reset

    assert !File.exists?(@filename)
    db = Titanium::Database::DB.new(@filename, 'test')
    assert File.exists?(@filename)
  end

  def test_close
    @db.close
    assert_raise SQLite3::MisuseException do
      @db.execute('SELECT * FROM test')
    end
  end

  def test_execute_insert
    assert_nothing_raised do
      @db.execute("INSERT INTO test (name) VALUES ('Myles')")
      real = SQLite3::Database.new(@filename)
      res = real.execute("SELECT * FROM test")
      assert 1, res.size
      res.each do |r|
        assert_equal [ 'Myles' ], r
      end
      assert_equal 1, @db.rowsAffected
      assert_equal 'test', @db.name
      assert_not_nil @db.lastInsertRowId
    end
  end

  def test_execute_select
    real = SQLite3::Database.new(@filename)
    real.execute("INSERT INTO test (name) VALUES ('Myles')")
    res = @db.execute('SELECT * FROM test')
    assert_equal res.class, Titanium::Database::ResultSet
  end

  def test_remove
    @db.remove
    assert !File.exists?(@filename)
  end
end
