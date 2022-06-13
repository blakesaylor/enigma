require 'date'
require './lib/shifter'

class Enigma
  include Shifter
  def initialize
    @key = generate_random_key_string
    @date = generate_todays_date_string
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

  def encrypt(message, key = @key, date = @date)
    keys = generate_keys_hash(key)
    offsets = generate_offset_keys_hash_from_date(date)
    shifts = generate_shifts_hash(keys, offsets)
    encrypted_message = encrypt_message(shifts, message)
    encrypted_file = File.open('encrypted.txt', 'w')
    encrypted_file.write(encrypted_message)
    encrypted_file.close
    encrypted_output_hash = { encryption: encrypted_message, key: key, date: date }
  end

  def decrypt(message, key = @key, date = @date)
    keys = generate_keys_hash(key)
    offsets = generate_offset_keys_hash_from_date(date)
    shifts = generate_shifts_hash(keys, offsets)
    decrypted_message = decrypt_message(shifts, message)
    decrypted_file = File.open('decrypted.txt', 'w')
    decrypted_file.write(decrypted_message)
    decrypted_file.close
    decrypted_output_hash = { decryption: decrypted_message, key: key, date: date }
  end
end
