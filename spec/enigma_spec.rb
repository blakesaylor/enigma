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
end
