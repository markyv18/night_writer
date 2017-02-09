
require 'minitest/autorun'
require 'minitest/pride'
require './lib/read_in_text.rb'

class ReadInMsgTest < Minitest::Test

  def test_weve_got_message
    read = ReadText.new('message.txt')
    assert_equal read.imported_text, File.open('./data/message.txt', 'r').read
  end
end
