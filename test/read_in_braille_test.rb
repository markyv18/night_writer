gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require'./lib/read_in_braille'

class ReadInTest < Minitest::Test


  def test_weve_got_braille
    read = ReadBraille.new('braille.txt')
    assert_equal read.imported_braille, File.open('./data/braille.txt', 'r').read
  end
end
