require 'date'

class Enigma
  attr_reader :message
  def initialize
    @message = ''
  end

  def parse_message(filename)
    file = File.new(filename)
    @message = file.read
  end
end
