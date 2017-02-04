require 'minitest/autorun'
require 'minitest/pride'
require './lib/read_in_text.rb'

class ReadInTest < Minitest::Test

# include these characters in the message.txt to satisfy the tests A R G V ? !  

  def test_weve_got_text
    read = ReadText.new(ARGV[0])
    assert read.imported_text.include?("A")
  end

  def test_weve_got_text1
    read = ReadText.new(ARGV[0])
    assert read.imported_text.include?("R")
  end

  def test_weve_got_text2
    read = ReadText.new(ARGV[0])
    assert read.imported_text.include?("G")
  end

  def test_weve_got_text3
    read = ReadText.new(ARGV[0])
    assert read.imported_text.include?("V")
  end

  def test_weve_got_text4
    read = ReadText.new(ARGV[0])
    assert read.imported_text.include?("?")
  end

  def test_weve_got_text5
    read = ReadText.new(ARGV[0])
    assert read.imported_text.include?("!")
  end

end
