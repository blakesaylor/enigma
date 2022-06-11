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

  def generate_random_key_string
    key = rand(0..99999).to_s.rjust(5, '0')
  end
end
