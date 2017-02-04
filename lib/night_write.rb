require_relative './read_in_text'

class NightWrite

attr_reader :braille_output, :text_to_convert

  def initialize
    read = ReadText.new(ARGV[0])
    @text_to_convert = read.imported_text.chars
    @braille_output = []
    @convert_chars_key = {"a" => ["0.","..",".."], "b" => ["0.","0.",".."], "c" => ["00","..",".."], "d" => ["00",".0",".."],
    "e" => ["0.",".0",".."], "f" => ["00","0.",".."], "g" => ["00","00",".."], "h" => ["0.","00",".."],
    "i" => [".0","0.",".."], "j" => [".0","00",".."], "k" => ["0.","..","0."], "l" => ["0.","0.","0."],
    "m" => ["00","..","0."], "n" => ["00",".0","0."], "o" => ["0.",".0","0."], "p" => ["00","0.","0."],
    "r" => ["0.","00","0."], "s" => [".0","0.","0."], "t" => [".0","00","0."], "u" => ["0.","..","00"],
    "v" => ["0.","0.","00"], "w" => [".0","00",".0"], "x" => ["00","..","00"], "y" => ["00",".0","00"],
    "z" => ["0.",".0","00"], "!" => ["..","00","0."], "'" => ["..","..","0."], "," => ["..","0.",".."],
    "-" => ["..","..","00"], "." => ["..","00",".0"], "?" => ["..","0.","00"], :caps => ["..", "..", ".0"],
    "#" => [".0", ".0", "00"], " " => ["..","..",".."]}
    @convert_nums_key  = {"0" => ".000..", "1" => "0.....", "2" => "0.0...","3" => "00....", "4" => "00.0..",
      "5" => "0..0..","6" => "000...", "7" => "0000..", "8" => "0.00..","9" =>  ".00...", :number => ".0.0.."}
  end

  def convert_to_braille
    convert_text_to_braille
    write_to_braille_file
  end




  def convert_text_to_braille
    @text_to_convert.each do |char|
      if @convert_chars_key.has_key?(char)
        @braille_output << @convert_chars_key.values_at(char)
      # elsif @convert_nums_key.key?(char)
      #   convert_numbers_to_braille(char)
      # elsif letters_to_braille.key?(char.downcase)
      #   braille << letters_to_braille[:capital] << letters_to_braille[char.downcase]
      end
    end
    @braille_output.flatten!
    @braille_print = @braille_output.join
  end

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

  def write_to_braille_file
    File.write(ARGV[1], @braille_print)
  end

end

night = NightWrite.new
night.convert_to_braille
