require_relative './read_in_braille'
# Imports braille file and writes conversion to Message.txt
class NightRead
  attr_reader :text_output,
              :braille_to_convert,
              :braille_array,
              :braille_sentence,
              :braille_letter,
              :text_array,
              :text_sentence

  def initialize
    read = ReadBraille.new(ARGV[0])
    @braille_to_convert = read.imported_braille
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

  def alphabet
    @alphabet = { 'a' => ['0.', '..', '..'], 'b' => ['0.', '0.', '..'],
                  'c' => ['00', '..', '..'], 'd' => ['00', '.0', '..'],
                  'e' => ['0.', '.0', '..'], 'f' => ['00', '0.', '..'],
                  'g' => ['00', '00', '..'], 'h' => ['0.', '00', '..'],
                  'i' => ['.0', '0.', '..'], 'j' => ['.0', '00', '..'],
                  'k' => ['0.', '..', '0.'], 'l' => ['0.', '0.', '0.'],
                  'm' => ['00', '..', '0.'], 'n' => ['00', '.0', '0.'],
                  'o' => ['0.', '.0', '0.'], 'p' => ['00', '0.', '0.'],
                  'q' => ['00', '00', '0.'], 'r' => ['0.', '00', '0.'],
                  's' => ['.0', '0.', '0.'], 't' => ['.0', '00', '0.'],
                  'u' => ['0.', '..', '00'], 'v' => ['0.', '0.', '00'],
                  'w' => ['.0', '00', '.0'], 'x' => ['00', '..', '00'],
                  'y' => ['00', '.0', '00'], 'z' => ['0.', '.0', '00'],
                  '!' => ['..', '00', '0.'], "'" => ['..', '..', '0.'],
                  ',' => ['..', '0.', '..'], '-' => ['..', '..', '00'],
                  '.' => ['..', '00', '.0'], '?' => ['..', '0.', '00'],
                  '^' => ['..', '..', '.0'], '#' => ['.0', '.0', '00'],
                  ' ' => ['..', '..', '..'] } 

                  #'and' => ['00', '0.', '00'],
                  # 'for' => ['00', '00', '00'], 'of' => ['0.', '00', '00'],
                  # 'the' => ['.0', '0.', '00'], 'with' => ['.0', '00', '00'],
                  # 'ch' => ['0.', '..', '.0'] }
  end

  def numbers
    @number = { '#j' => '0', '#a' => '1', '#b' => '2', '#c' => '3',
                '#d' => '4', '#e' => '5', '#f' => '6', '#g' => '7',
                '#h' => '8', '#i' => '9' }
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
p night.text_sentence
