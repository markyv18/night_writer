require_relative './read_in_text'
require_relative './dictionary'

class NightWrite

attr_reader :braille_output, :text_to_convert

  def initialize(read_in_text = ARGV[0])
    @dictionary = Dictionary.new
    @alpha = @dictionary.alphabet
    @nums = @dictionary.numbers
    read = ReadText.new(read_in_text)
    @text = read.imported_text.chomp.chars
    @conversion_text = []
    find_nums_and_caps_in_msg
    number_converter
    @text2 = @text1
    @text3 = @text1
require "pry"; binding.pry
  end
  # returns equal @text1, @text2, @text3

  def find_nums_and_caps_in_msg
    @text.each do |char|
      if ("A".."z") === char
        if char == char.upcase
        @conversion_text << "^#{char.downcase}"
        end
      else
        @conversion_text << char
      end
    end
  end
  #returns @conversion_text

  def number_converter
    @text1 = @conversion_text.map do |char|
      if @nums.has_value?(char)
        @nums.key(char)
      else
        char
      end
    end
  end
  #converts numbers to braille number representation and returns @text1

  def convert_to_braille
    convert_braille_first_line
    convert_braille_second_line
    convert_braille_third_line
    write_to_braille_file
  end

  def convert_braille_first_line
      @braille_line1 = @text1.map do |char|
        if @alpha.has_value?(char) || @nums.has_value?(char)
         @alpha.values_at(char)[0]

        braille_line_one_conversion(char)

      end
    end
  end


  def braille_line_one_conversion(char)
        if char.upcase?

          @alpha.has_key?(char)
           @alpha.values_at(char)[0]

        @text_to_convert[index].each do |char|
          # elsif @convert_nums_key.key?(char)
          #   convert_numbers_to_braille(char)
          # elsif letters_to_braille.key?(char.downcase)
          #   braille << letters_to_braille[:capital] << letters_to_braille[char.downcase]
          end
        end
    end

  #   @braille_output.each do |two_line|
  #     @braille_print1 << two_line[0]
  #     @braille_print2 << two_line[1]
  #     @braille_print3 << two_line[2]
  #   end
  #   @braille_print1 << "\n"
  #   @braille_print2 << "\n"
  #   @braille_print3 << "\n"
  #   @braille_p1 = @braille_print1.join
  #   @braille_p2 = @braille_print2.join
  #   @braille_p3 = @braille_print3.join
  # end
  #


  # def braille_numbers_to_text(message, char)
  #   next_character_index = message.index(char) + 1
  #   next_character = message[message.index(char)+ 1]
  #   text << number_to_braille.invert[next_character]
  #   message.delete_at(next_character_index)
  # end
  #
  # def braille_capital_to_text(message,char)
  #   next_character = message[message.index(char)+ 1]
  #   message.delete_at message.index(char)
  #   text << letters_to_braille.invert[next_character].upcase
  # end
  #
  # def braille_to_text(message)
  #     message.each do |char|
  #     next_character_index = message.index(char) + 1
  #     next_character = message[message.index(char)+ 1]
  #       case
  #       when char == "......"
  #         text << letters_to_braille.invert[char]
  #       when char == ".0.0.."
  #         braille_numbers_to_text(message,char)
  #       when number_to_braille.key?(text.last)
  #           text << number_to_braille.invert[char]
  #       when char == ".....0"
  #         braille_capital_to_text(message,char)
  #       else
  #         text << letters_to_braille.invert[char]
  #     end
  # end
  # text.join
  # end
  #
  # def convert!(message)
  #   if message[0][0] == "." || message[0][0] == "0"
  #     braille_to_text(message)
  #   else
  #     text_to_braille(message)
  #   end
  # end
  #
  # def wrap_text(converted_text)
  #   line_limit      = []
  #   converted_text  = converted_text.chars
  #   character_split = converted_text.map {|char| char.scan(/.{1,2}/)}
  #   split_line      = character_split.transpose.map {|line| line.join}
  #   until split_line[0].empty?
  #     split_line.each do |line|
  #         line_limit << line.slice!(0..79)+"\n"
  #       end
  #   end
  # line_limit.join("")
  # end
#
# end

  def print_braille_lines
    p @braille_p1
    p @braille_p2
    p @braille_p3
  end

  def write_to_braille_file
    File.write("./data/" + ARGV[1], @braille_p1)
    p "Created #{ARGV[1]} containing #{@braille_count} characters"
  end

end

night = NightWrite.new
night.convert_to_braille












#
