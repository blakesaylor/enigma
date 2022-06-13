require 'date'
require './lib/shifter'

class Enigma
  include Shifter

  attr_reader :message, :character_list

  def initialize
    @message = ''
    @character_list = ("a".."z").to_a << " "
  end

  def parse_message(filename)
    file = File.new(filename)
    @message = file.read.downcase
  end

  def encrypt_message(shift_hash, message)
    index = 0
    while index <= message.length - 1
      shift_value = get_shift_value(shift_hash, index)
      message[index] = get_new_char_by_shift(shift_value, message[index])
      index += 1
    end
    message
  end

  def decrypt_message(shift_hash, message)
    index = 0
    while index <= message.length - 1
      shift_value = -get_shift_value(shift_hash, index)
      message[index] = get_new_char_by_shift(shift_value, message[index])
      index += 1
    end
    message
  end
end
