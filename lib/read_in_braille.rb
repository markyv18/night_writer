# Opens and reads braille file
class ReadBraille
  attr_accessor :imported_braille

  def initialize(file_to_open)
    @imported_braille = File.open("./data/" + file_to_open, 'r').read
  end
end
