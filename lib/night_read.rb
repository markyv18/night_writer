require './lib/read_in_braille'
require './lib/dictionary'
# Imports braille file and writes conversion to Message.txt
class NightRead
  attr_reader :text_output,
              :braille_to_convert,
              :braille_array,
              :braille_sentence,
              :braille_letter,
              :text_array,
              :text_sentence,
              :alphabet,
              :numbers

  def initialize
    read = ReadBraille.new(ARGV[0])
    @braille_to_convert = read.imported_braille
    dictionary = Dictionary.new
    @alphabet = dictionary.alphabet
    @numbers = dictionary.numbers
    @braille_sentence = []
  end

  def convert_to_array
    @braille_array = braille_to_convert.split(/\n/)
    reduce_to_one_line
  end

  def reduce_to_one_line
    combine_line until braille_array[3].nil?
  end

  def combine_line
    for i in 0..2
      braille_array[i] += braille_array.delete_at(3)
    end
  end

  def make_lettered_array
    make_letter until braille_array[0].empty?
  end

  def make_letter
    @braille_letter = braille_array.map { |line| line.slice!(0..1) }
    braille_sentence << braille_letter
  end

  def convert_to_text_array
    @text_array = braille_sentence.map { |letter| alphabet.key(letter) }
  end

  def join_array_into_string
    @text_sentence = text_array.join
  end

  def capitalize
    text_sentence.gsub!(/\^./) { |letter| letter.delete('^').upcase }
  end

  def numberize
    text_sentence.gsub!(/\#./) { |letter| numbers[letter] }
  end

  def write_to_file
    File.write('./data/' + ARGV[1], text_sentence)
  end


end

night = NightRead.new

puts night.braille_to_convert
night.convert_to_array
night.make_lettered_array
night.convert_to_text_array
night.join_array_into_string
night.capitalize
night.numberize
night.text_sentence
night.write_to_file
