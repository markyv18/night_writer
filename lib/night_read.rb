require './lib/read_in_braille'
require './lib/dictionary'
# Imports braille file and writes conversion to Message.txt

class NightRead
  attr_reader :braille,
              :alphabet_hash,
              :numbers_hash,
              :braille_sentence,
              :braille_array,
              :braille_letter,
              :text_array,
              :text_sentence,
              :text_output

  def initialize(read_file = ARGV[0])
    read = ReadBraille.new(read_file)
    @braille = read.imported_braille
    dictionary = Dictionary.new
    @alphabet_hash = dictionary.alphabet
    @numbers_hash = dictionary.numbers
    @braille_sentence = []
  end

  def convert_to_array(braille_to_convert = braille)
    @braille_array = braille_to_convert.split(/\n/)
    reduce_to_3_lines(braille_array)
  end

  def reduce_to_3_lines(array)
    combine_line(array) until array[3].nil?
  end

  def combine_line(array)
    for i in 0..2
      array[i] += array.delete_at(3)
    end
  end

  def make_lettered_array(array = braille_array)
    make_letter(array) until array[0].empty?
  end

  def make_letter(array)
    @braille_letter = array.map { |line| line.slice!(0..1) }
    braille_sentence << braille_letter
  end

  def convert_to_text_array(array = braille_sentence)
    @text_array = array.map { |letter| alphabet_hash.key(letter) }
  end

  def join_array_into_string(array = text_array)
    @text_sentence = array.join
  end

  def capitalize(text = text_sentence)
    text.gsub!(/\^./) { |letter| letter.delete('^').upcase }
  end

  def numberize(text = text_sentence)
    text.gsub!(/\#./) { |letter| numbers_hash[letter] }
  end

  def write_to_file
    File.write('./data/' + ARGV[1], text_sentence)
  end

  def operate
    convert_to_array
    make_lettered_array
    convert_to_text_array
    join_array_into_string
    capitalize
    numberize
    text_sentence
  end
end

night = NightRead.new

night.operate
night.write_to_file
