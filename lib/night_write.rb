require_relative './read_in_text'

class NightWrite

attr_reader :braille_output, :text_to_convert

  def initialize
    read = ReadText.new(ARGV[0])
    @text_to_convert = read.imported_text
    # key = EnglishToBraille.new
    # @braille_conversion_chart = key.english_to_braile
    # @braille_num_conversion_chart = key.letters_to_numbers
  end

end

night = NightWrite.new
p night.text_to_convert

# class EnglishToBraille
#   attr_reader :english_to_braile, :letters_to_numbers
#
#   def english_to_braile
#    {"a" => ["0.","..",".."], "b" => ["0.","0.",".."], "c" => ["00","..",".."], "d" => ["00",".0",".."],
#    "e" => ["0.",".0",".."], "f" => ["00","0.",".."], "g" => ["00","00",".."], "h" => ["0.","00",".."],
#    "i" => [".0","0.",".."], "j" => [".0","00",".."], "k" => ["0.","..","0."], "l" => ["0.","0.","0."],
#    "m" => ["00","..","0."], "n" => ["0.",".0","0."], "o" => ["0.",".0","0."], "p" => ["00","0.","0."],
#    "r" => ["0.","00","0."], "s" => [".0","0.","0."], "t" => [".0","00","0."], "u" => ["0.","..","00"],
#    "v" => ["0.","0.","00"], "w" => [".0","00",".0"], "x" => ["00","..","00"], "y" => ["00",".0","00"],
#    "z" => ["0.",".0","00"], "!" => ["..","00","0."], "'" => ["..","..","0."], "," => ["..","0.",".."],
#    "-" => ["..","..","00"], "." => ["..","00",".0"], "?" => ["..","0.","00"], "capitals" => ["..", "..", ".0"],
#    "numbers" => [".0", ".0", "00"], " " => ["..","..",".."]}
#  end
#
#  def  letters_to_numbers
#    { "j" => "0", "a" => "1", "b" => "2", "c" => "3", "d" => "4",
#    "e" => "5", "f" => "6", "g" => "7", "h" => "8", "i" => "9"}
#  end
# end
