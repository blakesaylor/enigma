require './lib/enigma'

RSpec.describe Enigma do
  before :each do
    @enigma = Enigma.new
  end

  describe '#initialize' do
    it 'is an Enigma' do
      expect(@enigma).to be_a Enigma
    end
  end

end
