require_relative './read_in_text'
require_relative './dictionary'

class NightWrite

attr_reader :braille_output, :text_to_convert

  def initialize(read_in_text = ARGV[0])
    @dictionary = Dictionary.new
    @alpha = @dictionary.alphabet
    @nums = @dictionary.numbers
    read = ReadText.new(read_in_text).imported_text.chomp.chars
    prepare_message_for_conversion_braille(read)
  end

  def prepare_message_for_conversion_braille(read)
    number_converter(read)
    find_caps_in_msg
  end

  def number_converter(text)
    @message_with_numbers_converted = []
    text.each do |char|
      if @nums.has_value?(char)
        @message_with_numbers_converted << @nums.key(char)[0]
        @message_with_numbers_converted << @nums.key(char)[1]
      else
        @message_with_numbers_converted << char
      end
    end
  end

  def find_caps_in_msg
    @message_ready_for_braille = []
    @message_with_numbers_converted.each do |char|
      if ("A".."z") === char && (char == char.upcase)
        @message_ready_for_braille << "^"
        @message_ready_for_braille << char.downcase
      else
        @message_ready_for_braille << char
      end
    end
  end

  def convert_to_braille
    convert_braille_first_line
    convert_braille_second_line
    convert_braille_third_line
    print_braille_lines
    write_to_braille_file
    break_braille_into_lines_less_than_80
  end

  def convert_braille_first_line
    line = @message_ready_for_braille.map do |char|
      @alpha.values_at(char)[0][0]
    end
    @braille_line1 = line.join
  end

  def convert_braille_second_line
    line = @message_ready_for_braille.map do |char|
      @alpha.values_at(char)[0][1]
    end
    @braille_line2 = line.join
  end

  def convert_braille_third_line
    line = @message_ready_for_braille.map do |char|
      @alpha.values_at(char)[0][2]
    end
    @braille_line3 = line.join
  end

  def break_braille_into_lines_less_than_80
  end

  def print_braille_lines
    @braille = @braille_line1 + "\n" + @braille_line2 + "\n" + @braille_line3
  end

  def write_to_braille_file
    File.write("./data/" + ARGV[1], print_braille_lines)
    p "Created #{ARGV[1]} containing #{@braille_line1.size} characters"
  end

end

night = NightWrite.new
night.convert_to_braille












#
