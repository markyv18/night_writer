class ReadText
  attr_accessor :imported_text

  def initialize(file_to_open)
    @imported_text = File.open("./data/" + file_to_open, "r").read
  end

end
