require_relative './read_in_text'
require_relative './dictionary'

class NightWrite

  attr_reader :alpha,
              :nums,
              :message,
              :text_array,
              :braille_array,
              :combined_braille_array,
              :seperated_braille_array,
              :length

  def initialize(read_in_text = ARGV[0])
    @dictionary = Dictionary.new
    @alpha = @dictionary.alphabet
    @nums = @dictionary.numbers
    @message = ReadText.new(read_in_text).imported_text
    @combined_braille_array = ['','','']
    @seperated_braille_array = []
    @length = message.length
  end

  def operate
    number_converter
    find_caps_in_msg
    make_text_array
    convert_to_braille
    combine_braille_array
    break_into_80_chars
    make_new_lines
    write_to_braille_file
  end

  def number_converter(text = message)
    text.gsub!(/[0-9]/) { |number| nums.key(number) }
  end

  def find_caps_in_msg(text = message)
    text.gsub!(/[A-Z]/) { |letter| "^" + letter.downcase}
  end

  def make_text_array(text = message)
    @text_array = text.chomp.chars
  end

  def convert_to_braille(array = text_array)
    @braille_array = array.map { |element| alpha[element] }
  end

  def combine_braille_array(array = braille_array)
    array.each { |item| combine_letter(item) }
  end

  def combine_letter(array)
    array.each_with_index do |item, i|
      combined_braille_array[i] << item
    end
  end

  def break_into_80_chars(array = combined_braille_array)
    array.map! do |line|
      line.scan(/.{1,80}/)
    end
  end

  def make_new_lines(array = combined_braille_array)
    array.each_index do |i|
      seperated_braille_array << array[0][i] + "\n" + array[1][i] + "\n" + array[2][i] + "\n"
    end
  end

  def write_to_braille_file(array = seperated_braille_array)
    File.write('./data/' + ARGV[1], array.join)
    puts "Created #{ARGV[1]} containing #{length} characters"
  end

end

night = NightWrite.new
night.operate
