require_relative './read_in_braille'

class NightRead
  attr_reader :text_output, :braille_to_convert, :braille_array, :braille_sentence, :braille_letter, :text_sentence_array, :text_sentence

  def initialize
    read = ReadBraille.new(ARGV[0])
    @braille_to_convert = read.imported_braille
    @braille_sentence = []
  end

  def convert_to_array
    @braille_array = braille_to_convert.split(/\n+/)
  end

  def make_lettered_array
    until braille_array[0].empty?
      make_letter
      braille_sentence << braille_letter
    end
    braille_sentence
  end

  def make_letter
    @braille_letter = braille_array.map do |line|
      line.slice!(0..1)
    end
  end

  def convert_to_text
    @text_sentence_array = braille_sentence.map do |letter|
      alphabet.key(letter)
    end
    @text_sentence = text_sentence_array.join
  end

  def capitalize_and_numberize
    text_sentence.gsub!(/\^./) {|letter| letter.delete("^").upcase}
    text_sentence.gsub!(/\#./) do |letter|
      numbers[letter]
    end
  end

  def alphabet
    @alphabet = {"a" => ["0.","..",".."], "b" => ["0.","0.",".."], "c" => ["00","..",".."], "d" => ["00",".0",".."], "e" => ["0.",".0",".."], "f" => ["00","0.",".."], "g" => ["00","00",".."], "h" => ["0.","00",".."], "i" => [".0","0.",".."], "j" => [".0","00",".."], "k" => ["0.","..","0."], "l" => ["0.","0.","0."], "m" => ["00","..","0."], "n" => ["00",".0","0."], "o" => ["0.",".0","0."], "p" => ["00","0.","0."], "r" => ["0.","00","0."], "s" => [".0","0.","0."], "t" => [".0","00","0."], "u" => ["0.","..","00"], "v" => ["0.","0.","00"], "w" => [".0","00",".0"], "x" => ["00","..","00"], "y" => ["00",".0","00"], "z" => ["0.",".0","00"], "!" => ["..","00","0."], "'" => ["..","..","0."], "," => ["..","0.",".."], "-" => ["..","..","00"], "." => ["..","00",".0"], "?" => ["..","0.","00"], "^" => ["..", "..", ".0"], "#" => [".0", ".0", "00"], " " => ["..","..",".."]}
  end

  def numbers
    @number =    { "#j" => "0", "#a" => "1", "#b" => "2", "#c" => "3", "#d" => "4", "#e" => "5", "#f" => "6", "#g" => "7", "#h" => "8", "#i" => "9"}
  end
end

night = NightRead.new

puts night.braille_to_convert
p night.convert_to_array
p night.make_lettered_array
p night.convert_to_text
p night.capitalize_and_numberize
