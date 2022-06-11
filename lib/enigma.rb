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

  def generate_keys_hash(key)
    key_hash = {
      a_key: key[0..1].to_i,
      b_key: key[1..2].to_i,
      c_key: key[2..3].to_i,
      d_key: key[3..4].to_i
    }
  end

  def generate_random_key_hash
    five_digit_key = generate_random_key_string
    key_hash = generate_keys_hash(five_digit_key)
  end

  def valid_key_length?(key)
    key_chars = key.chars
    if key_chars.length != 5
      return false
    end
    true
  end

  def valid_key_digits?(key)
    key_chars = key.chars
    key_chars.each do |char|
      if !char.ord.between?(48,57)
        return false
      end
    end
    true
  end

  def create_5_length_key(key)
    key.rjust(5, '0')
  end
end
