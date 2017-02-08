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

  def convert_to_braille_runner
    convert_braille_first_line
    convert_braille_second_line
    convert_braille_third_line
    print_braille_lines
    # break_braille_into_lines_less_than_80
    #depending on what break_braille_into_lines_less_than_80 returns
    #alter write_to_braille_file to print accordingly
    write_to_braille_file
  end

  def convert_braille_first_line
    line = @message_ready_for_braille.map do |char|
      @alpha.values_at(char)[0][0]
    end
    line.join
  end

  def convert_braille_second_line
    line = @message_ready_for_braille.map do |char|
      @alpha.values_at(char)[0][1]
    end
    line.join
  end

  def convert_braille_third_line
    line = @message_ready_for_braille.map do |char|
      @alpha.values_at(char)[0][2]
    end
    line.join
  end

  def break_braille_into_lines_less_than_80
    if convert_braille_first_line > 80

    if convert_braille_first_line > 80
      
    if convert_braille_first_line > 80


    index = 0
    while index < braille_translation.length
      if  braille_translation[index].length > 80
        braille_translation[index + 3] = braille_translation[index][80..-1]
        braille_translation[index] = braille_translation[index][0..79]
      end
      index += 1
    end
    braille_translation
  end

  def print_braille_lines
    convert_braille_first_line + "\n" + convert_braille_second_line + "\n" + convert_braille_third_line
  end

  def write_to_braille_file
    File.write("./data/" + ARGV[1], print_braille_lines)
    p "Created #{ARGV[1]} containing #{convert_braille_first_line.size} characters"
  end

end

night = NightWrite.new
night.convert_to_braille_runner











#
