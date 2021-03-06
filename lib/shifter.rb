require 'date'

module Shifter
  def character_list
    ("a".."z").to_a << " "
  end

  def parse_message(filename)
    file = File.new(filename)
    message = file.read.downcase
  end

  def write_message(message, output_filename)
    output_file = File.open(output_filename, 'w')
    output_file.write(message)
    output_file.close
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

  def generate_todays_date_string
    date_object = Date.today
    date_string = date_object.strftime('%d%m%y')
  end

  def generate_four_digit_offset(date_string)
    squared_date = date_string.to_i ** 2
    four_digit_offset = squared_date.to_s[-4..-1]
  end

  def generate_offset_keys_hash(four_digit_offset)
    offset_hash = {
      a_offset: four_digit_offset[0].to_i,
      b_offset: four_digit_offset[1].to_i,
      c_offset: four_digit_offset[2].to_i,
      d_offset: four_digit_offset[3].to_i
    }
  end

  def generate_todays_offset_hash
    numeric_date = generate_todays_date_string
    four_digit_offset = generate_four_digit_offset(numeric_date)
    offset_hash = generate_offset_keys_hash(four_digit_offset)
  end

  def generate_offset_keys_hash_from_date(date)
    four_digit_offset = generate_four_digit_offset(date)
    offset_keys_hash = generate_offset_keys_hash(four_digit_offset)
  end

  def generate_shifts_hash(keys, offsets)
    final_shifts = {
      a_shift: keys[:a_key] + offsets[:a_offset],
      b_shift: keys[:b_key] + offsets[:b_offset],
      c_shift: keys[:c_key] + offsets[:c_offset],
      d_shift: keys[:d_key] + offsets[:d_offset]
    }
  end

  def get_new_char_by_shift(shift, input_char)
    new_char = input_char
    if character_list.include?(input_char)
      index_value = character_list.index(input_char)
      rotated_char_list = character_list.rotate(shift)
      new_char = rotated_char_list[index_value]
    end
    new_char
  end

  def get_shift_value(shift_hash, index)
    shift_value = shift_hash[:a_shift] if (index % 4) == 0
    shift_value = shift_hash[:b_shift] if (index % 4) == 1
    shift_value = shift_hash[:c_shift] if (index % 4) == 2
    shift_value = shift_hash[:d_shift] if (index % 4) == 3
    shift_value
  end
end
