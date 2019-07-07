require 'vending_machine'

describe Vending_Machine do

  let(:machine) { described_class.new }

  describe '#restock' do
    it 'Products are reloaded' do
      expect(machine.restock).to include({:name=>"Cheetos", :price=>0.5, :quantity=>10})
    end
  end

  describe '#reload_change' do
    it 'Change is reloaded' do
      expect(machine.reload_change).to include({:denomination=>2.00, :amount=>5})
    end
  end

  describe '#purchase' do
    it 'Items can be purchased from vending machine' do
      machine.restock
      machine.purchase("Cheetos", 0.5)
      expect(machine.restock).to include({:name=>"Cheetos", :price=>0.5, :quantity=>10})
    end

    it 'Does not allow a user to purchase non existent items' do
      machine.restock
      expect(machine.purchase("Quavers", 0.5)).to eq("No such item")
    end

    it 'Does not allow a user to purchase out of stock items' do
      machine.restock
      5.times do
        machine.purchase("Pringles", 0.60)
      end
      expect(machine.purchase("Pringles", 0.60)).to eq("Out of stock")
    end

    it 'Informs a user if not enough money inserted' do
      machine.restock
      expect(machine.purchase("Cheetos", 0.2)).to eq("Insufficient funds")
    end
  end
end
