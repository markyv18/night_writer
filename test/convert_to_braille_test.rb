gem 'minitest', '~> 5.2'
require 'launchy'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/night_write'

class ConvertToBrailleTest < Minitest::Test

  def test_number_converter
    write = NightWrite.new('message.txt')
    assert_equal "He#f", write.number_converter("He6")
  end

  def test_find_caps_in_msg
    write = NightWrite.new('message.txt')
    assert_equal "^he#f", write.find_caps_in_msg("He#f")
  end

  def test_make_text_array
    write = NightWrite.new('message.txt')
    assert_equal Array, write.make_text_array.class
  end

  def test_make_text_array2
    write = NightWrite.new('message.txt')
    assert_equal ["^","h","e","#","f"], write.make_text_array("^he#f")
  end

  def test_convert_to_braille
    write = NightWrite.new('message.txt')
    assert_equal [['..', '..', '.0'],['0.', '00', '..'],['0.', '.0', '..'],['.0', '.0', '00'],['00', '0.', '..']], write.convert_to_braille(["^","h","e","#","f"])
  end

  def test_combine_braille_array
    write = NightWrite.new('message.txt')
    write.combine_braille_array([['..', '..', '.0'],['0.', '00', '..'],['0.', '.0', '..'],['.0', '.0', '00'],['00', '0.', '..']])
    assert_equal ["..0.0..000", "..00.0.00.", ".0....00.."], write.combined_braille_array
  end

  def test_break_into_80_chars(array = combined_braille_array)
    write = NightWrite.new('message.txt')
    
  end




end

# p "hit enter for some fun and the tests to run"
# gets.chomp
# Launchy.open("https://www.youtube.com/watch?v=GbfVmzF7N4g")
































#
