gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/read_in_text'

class ReadInTest < Minitest::Test

  def test_weve_got_text
    read = ReadText.new('message.txt')
    assert read.include("?")
    assert read.include("A")
    assert read.include("R")
    assert read.include("f")
    assert read.include("_")
  end
end
