require 'date'
require './lib/shifter'

class Enigma
  include Shifter
  attr_reader :key, :date

  def initialize
    @key = generate_random_key_string
    @date = generate_todays_date_string
  end

  def encrypt_message(shift_hash, input_message)
    index = 0
    output_message = ''
    while index <= input_message.length - 1
      shift_value = get_shift_value(shift_hash, index)
      output_message[index] = get_new_char_by_shift(shift_value, input_message[index])
      index += 1
    end
    output_message
  end

  def decrypt_message(shift_hash, input_message)
    index = 0
    output_message = ''
    while index <= input_message.length - 1
      shift_value = -get_shift_value(shift_hash, index)
      output_message[index] = get_new_char_by_shift(shift_value, input_message[index])
      index += 1
    end
    output_message
  end

  def encrypt(message, key = @key, date = @date)
    keys = generate_keys_hash(key)
    offsets = generate_offset_keys_hash_from_date(date)
    shifts = generate_shifts_hash(keys, offsets)
    encrypted_message = encrypt_message(shifts, message)
    encrypted_output_hash = { encryption: encrypted_message, key: key, date: date }
  end

  def decrypt(message, key = @key, date = @date)
    keys = generate_keys_hash(key)
    offsets = generate_offset_keys_hash_from_date(date)
    shifts = generate_shifts_hash(keys, offsets)
    decrypted_message = decrypt_message(shifts, message)
    decrypted_output_hash = { decryption: decrypted_message, key: key, date: date }
  end

  def write_message(message, output_filename)
    output_file = File.open(output_filename, 'w')
    output_file.write(message)
    output_file.close
  end
end
