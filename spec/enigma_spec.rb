require './lib/enigma'

RSpec.describe Enigma do
  before :each do
    @enigma = Enigma.new
  end

  describe '#initialize' do
    it 'is an Enigma' do
      expect(@enigma).to be_a Enigma
    end

    it 'has a randomly generated 5 character key string' do
      expect(@enigma.key.length).to eq 5
      expect(@enigma.key).to be_a String
    end

    it 'has a date string in the format of ddmmyy that is today' do
      expect(@enigma.date.length).to eq 6
      expect(@enigma.date).to be_a String
    end
  end

  describe '#character_list' do
    it 'has a list of 27 characters (a through z and space)' do
      expect(@enigma.character_list.length).to eq 27
      expect(@enigma.character_list).to be_a Array
      expect(@enigma.character_list.last).to eq " "
    end
  end

  describe '#parse_message' do
    it 'can parse a message from a file' do
      filename = 'message.txt'
      expected = 'hello world'
      expect(@enigma.parse_message(filename)).to eq 'hello world'
    end
  end

  describe '#generate_random_key_string' do
    it 'can generate a random five character key string with leading zeroes' do
      key = @enigma.generate_random_key_string
      expect(key).to be_a String
      expect(key.length).to eq 5
    end
  end

  describe '#generate_keys_hash' do
    it 'can generate a hash of A through D keys' do
      key = '02715'
      key_hash = @enigma.generate_keys_hash(key)
      expect(key_hash.keys).to eq [:a_key, :b_key, :c_key, :d_key]
      expect(key_hash.values).to eq [02, 27, 71, 15]
    end
  end

  describe '#generate_random_key_hash' do
    it 'can generate a hash of random keys in one step' do
      key_hash = @enigma.generate_random_key_hash
      expect(key_hash).to be_a Hash
      expect(key_hash.values.count).to eq 4
    end
  end

  describe '#generate_todays_date_string' do
    it 'can generate a string of the current date' do
      date_string = Date.today.strftime('%d%m%y')
      expect(@enigma.generate_todays_date_string).to eq date_string
    end
  end

  describe '#generate_four_digit_offset' do
    it 'can generate a four digit offset (string) from a date' do
      date = '040895'
      expected_offset = '1025'
      expect(@enigma.generate_four_digit_offset(date)).to eq expected_offset
    end
  end

  describe '#generate_offset_keys_hash' do
    it 'can generate a hash of offset A through D keys' do
      date_offset = '1025'
      offsets_hash = @enigma.generate_offset_keys_hash(date_offset)
      expect(offsets_hash).to be_a Hash
      expect(offsets_hash.keys).to eq [
        :a_offset,
        :b_offset,
        :c_offset,
        :d_offset
      ]
      expect(offsets_hash.values).to eq [1, 0, 2, 5]
    end
  end

  describe '#generate_todays_offset_hash' do
    it 'can generate a hash of offsets from no data in one step' do
      expect(@enigma.generate_todays_offset_hash).to be_a Hash
    end
  end

  describe '#generate_offset_keys_hash_from_date' do
    it 'can generate a offset keys hash from a user date input' do
      date = '040895'
      expected = {
        a_offset: 1,
        b_offset: 0,
        c_offset: 2,
        d_offset: 5
      }
      expect(@enigma.generate_offset_keys_hash_from_date(date)).to eq expected
    end
  end

  describe '#generate_shifts_hash' do
    it 'can create a hash of final shifts' do
      keys = { a_key: 02, b_key: 27, c_key: 71, d_key: 15 }
      offsets = { a_offset: 1, b_offset: 0, c_offset: 2, d_offset: 5 }
      shifts = { a_shift: 3, b_shift: 27, c_shift: 73, d_shift: 20 }
      expect(@enigma.generate_shifts_hash(keys, offsets)).to eq shifts
    end
  end

  describe '#get_new_char_by_shift' do
    it 'can rotate the character list instance variable to change a message character' do
      shift = 3
      input_char = 'h'
      output = 'k'
      expect(@enigma.get_new_char_by_shift(shift,input_char)).to eq output
      shift = 27
      input_char = 'e'
      output = 'e'
      expect(@enigma.get_new_char_by_shift(shift,input_char)).to eq output
      shift = 73
      input_char = 'l'
      output = 'd'
      expect(@enigma.get_new_char_by_shift(shift,input_char)).to eq output
    end

    it 'does not change a character that does not appear in the character list' do
      shift = 3
      input_char = '!'
      output = '!'
      expect(@enigma.get_new_char_by_shift(shift,input_char)).to eq output
      shift = 42
      input_char = '^'
      output = '^'
      expect(@enigma.get_new_char_by_shift(shift,input_char)).to eq output
    end
  end

  describe '#get_shift_value' do
    it 'can return a shift value for a specified index position in a message' do
      shifts = { a_shift: 3, b_shift: 27, c_shift: 73, d_shift: 20 }
      index = 3
      expect(@enigma.get_shift_value(shifts, index)).to eq shifts[:d_shift]
      index = 12
      expect(@enigma.get_shift_value(shifts, index)).to eq shifts[:a_shift]
      index = 14
      expect(@enigma.get_shift_value(shifts, index)).to eq shifts[:c_shift]
      index = 1
      expect(@enigma.get_shift_value(shifts, index)).to eq shifts[:b_shift]
    end
  end

  describe '#encrypt_message' do
    it 'can encrypt a message' do
      message = 'hello world'
      encrypted_message = 'keder ohulw'
      shifts = { a_shift: 3, b_shift: 27, c_shift: 73, d_shift: 20 }
      expect(@enigma.encrypt_message(shifts, message)).to eq encrypted_message
    end
  end

  describe '#decrypt_message' do
    it 'can decrypt a message' do
      message = 'hello world'
      encrypted_message = 'keder ohulw'
      shifts = { a_shift: 3, b_shift: 27, c_shift: 73, d_shift: 20 }
      expect(@enigma.decrypt_message(shifts, encrypted_message)).to eq message
    end
  end

  describe '#encrypt' do
    it 'can encrypt a message and write it to a file' do
      message = 'hello world'
      key = '02715'
      date = '040895'
      @enigma.encrypt(message, key, date)
      output_file = File.open('encrypted.txt', 'r')
      expect(output_file.read).to eq 'keder ohulw'
    end
  end

  describe '#decrypt' do
    it 'can decrypt a message and write it to a file' do
      message = 'keder ohulw'
      key = '02715'
      date = '040895'
      @enigma.decrypt(message, key, date)
      output_file = File.open('decrypted.txt', 'r')
      expect(output_file.read).to eq 'hello world'
    end
  end
end

# describe '#valid_key_length?' do
#   it 'returns true if the length of a key is valid (five chars)' do
#     key = '02715'
#     expect(@enigma.valid_key_length?(key)).to eq true
#   end
#
#   it 'returns false if the length of a key is invalid' do
#     key = '0271'
#     expect(@enigma.valid_key_length?(key)).to eq false
#   end
# end
#
# describe '#valid_key_digits?' do
#   it 'returns true if a key is made up of all numbers' do
#     key = '02715'
#     expect(@enigma.valid_key_digits?(key)).to eq true
#   end
#
#   it 'returns false if a key is not made up of all numbers' do
#     key = 'blake'
#     expect(@enigma.valid_key_digits?(key)).to eq false
#   end
# end
#
# describe '#create_5_length_key' do
#   it 'adds leading zeroes to a string if it is less than 5 characters' do
#     key = '715'
#     expect(@enigma.create_5_length_key(key)).to eq '00715'
#   end
# end
# describe '#get_date_integer_array' do
#   it 'can get an array in the form of year, month, day from a string input' do
#     input = '04-08-1995'
#     array = @enigma.get_date_integer_array(input)
#     expect(array).to eq [1995, 8, 4]
#   end
# end

# describe '#is_valid_date?' do
#   it 'can check if a date array makes up a valid date' do
#     array = [1995, 8, 4]
#     expect(@enigma.is_valid_date?(array)).to eq true
#     array = [2022, 13, 5]
#     expect(@enigma.is_valid_date?(array)).to eq false
#   end
# end
