gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require'./lib/night_read'


class ConvertToTextTest < Minitest::Test


  def test_convert_to_array
    night = NightRead.new('braille.txt')
    night.convert_to_array("0.\n..\n..")
    assert_equal ["0.", "..", ".."], night.braille_array
  end

  def test_multiline_to_array
    night = NightRead.new('braille.txt')
    night.convert_to_array("..0.\n....\n.0..\n0.\n..\n..")
    assert_equal ["..0.0.", "......", ".0...."], night.braille_array
  end

  def test_make_lettered_array
    night = NightRead.new('braille.txt')
    night.make_lettered_array(["..0.0.", "......", ".0...."])
    assert_equal [["..", "..", ".0"], ["0.", "..", ".."], ["0.", "..", ".."]], night.braille_sentence
  end

  def test_convert_to_text_array
    night = NightRead.new('braille.txt')
    night.convert_to_text_array([["..", "..", ".0"], ["0.", "..", ".."], ["0.", "..", ".."]])
    assert_equal ["^", "a", "a"], night.text_array
  end

  def test_join_array
    night = NightRead.new('braille.txt')
    assert_equal "^aa", night.join_array_into_string(["^", "a", "a"])
  end

  def test_capitalize
    night = NightRead.new('braille.txt')
    assert_equal "Aa", night.capitalize("^aa")
  end

  def test_numberize
    night = NightRead.new('braille.txt')
    assert_equal "12", night.numberize("#a#b")
  end

  def test_lowercase_letter
    File.write('./data/braille.txt', "0.\n..\n..")
    night = NightRead.new('braille.txt')
    night.operate

    assert_equal "a", night.text_sentence
  end

  def test_lowercase_letters
    File.write('./data/braille.txt', "0.0.\n..0.\n....")
    night = NightRead.new('braille.txt')
    night.operate

    assert_equal "ab", night.text_sentence
  end

  def test_upercase_letters
    File.write('./data/braille.txt', "..0...0.\n......0.\n.0...0..")
    night = NightRead.new('braille.txt')
    night.operate

    assert_equal "AB", night.text_sentence
  end

  def test_numbers
    File.write('./data/braille.txt', ".00..00..000.000.00..000.000.00..0.0.0.0\n.0...00..0...0.0.0.0.00..000.000.00..000\n00..00..00..00..00..00..00..00..00..00..")
    night = NightRead.new('braille.txt')
    night.operate

    assert_equal "1234567890", night.text_sentence
  end

  def test_multi_line_braille
    File.write('./data/braille.txt', "0.0.\n0.0.\n0.0.\n0.0.\n0.0.\n0.0.")
    night = NightRead.new('braille.txt')
    night.operate

    assert_equal "llll", night.text_sentence
  end

  def test_all_characters
    night = NightRead.new('all_characters.txt')
    night.operate

    assert_equal " !',-.?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890", night.text_sentence
  end
end
