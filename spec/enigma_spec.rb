require './lib/enigma'

RSpec.describe Enigma do
  before :each do
    @enigma = Enigma.new
  end

  describe '#initialize' do
    it 'is an Enigma' do
      expect(@enigma).to be_a Enigma
    end

    it 'has an empty message string' do
      expect(@enigma.message).to eq ''
    end

    it 'has a list of all possible characters to mutate' do
      expect(@enigma.character_list.count).to eq 27
    end
  end

  describe '#parse_message' do
    it 'can parse a message from a file' do
      @enigma.parse_message('message.txt')
      expect(@enigma.message).to eq 'hello world end'
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

  describe '#valid_key_length?' do
    it 'returns true if the length of a key is valid (five chars)' do
      key = '02715'
      expect(@enigma.valid_key_length?(key)).to eq true
    end

    it 'returns false if the length of a key is invalid' do
      key = '0271'
      expect(@enigma.valid_key_length?(key)).to eq false
    end
  end

  describe '#valid_key_digits?' do
    it 'returns true if a key is made up of all numbers' do
      key = '02715'
      expect(@enigma.valid_key_digits?(key)).to eq true
    end

    it 'returns false if a key is not made up of all numbers' do
      key = 'blake'
      expect(@enigma.valid_key_digits?(key)).to eq false
    end
  end

  describe '#create_5_length_key' do
    it 'adds leading zeroes to a string if it is less than 5 characters' do
      key = '715'
      expect(@enigma.create_5_length_key(key)).to eq '00715'
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
      date_offset = '1025'
      expect(@enigma.generate_four_digit_offset(date)).to eq date_offset
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

  describe '#generate_random_offset_hash' do
    it 'can generate a hash of offsets from no data in one step' do
      expect(@enigma.generate_random_offset_hash).to be_a Hash
    end
  end

  describe '#get_date_integer_array' do
    it 'can get an array in the form of year, month, day from a string input' do
      input = '04-08-1995'
      array = @enigma.get_date_integer_array(input)
      expect(array).to eq [1995, 8, 4]
    end
  end

  describe '#is_valid_date?' do
    it 'can check if a date array makes up a valid date' do
      array = [1995, 8, 4]
      expect(@enigma.is_valid_date?(array)).to eq true
      array = [2022, 13, 5]
      expect(@enigma.is_valid_date?(array)).to eq false
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
end
