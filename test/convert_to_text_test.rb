gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require'./lib/night_read'

class ConvertToTextTest < Minitest::Test
  def test_it_exists
    night = NightRead.new("message.txt")
    assert_instance_of NightRead, night
  end
end
