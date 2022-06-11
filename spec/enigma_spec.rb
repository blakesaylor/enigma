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
end
