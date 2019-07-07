require 'vending_machine'

describe Vending_Machine do

  let(:machine) { described_class.new }

  describe '#restock' do
    it 'Items can be added to vending machine' do
      expect(machine.restock).to include({:name=>"Cheetos", :price=>0.5, :quantity=>10})
    end
  end

  describe '#purchase' do
    it 'Items can be purchased from vending machine' do
      machine.restock
      machine.purchase("Cheetos", 0.5)
      expect(machine.restock).to include({:name=>"Cheetos", :price=>0.5, :quantity=>10})
    end
  end

end
