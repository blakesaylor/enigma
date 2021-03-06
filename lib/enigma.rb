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
    output_array = []
    input_message.chars.each_with_index do |character, index|
      shift_value = get_shift_value(shift_hash, index)
      output_array << get_new_char_by_shift(shift_value, character)
    end
    output_array.join
  end

  def decrypt_message(shift_hash, input_message)
    output_array = []
    input_message.chars.each_with_index do |character, index|
      shift_value = -get_shift_value(shift_hash, index)
      output_array << get_new_char_by_shift(shift_value, character)
    end
    output_array.join
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
end
