require 'vending_machine'

describe Vending_Machine do

  let(:machine) { described_class.new }

  describe '#restock' do
    it 'Items can be added to vending machine' do
      expect(machine.restock(0.5, "pringles")).to eq({ 0.5 => "pringles" })
    end
  end


end
