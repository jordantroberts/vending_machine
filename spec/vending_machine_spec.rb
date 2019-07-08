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
      machine.reload_change
      machine.purchase("Cheetos", [0.50])
      expect(machine.restock).to include({:name=>"Cheetos", :price=>0.5, :quantity=>10})
    end

    it 'Adds money for item to vending machine change' do
      machine.restock
      machine.reload_change
      machine.purchase("Pringles", [0.50, 0.10])
      expect(machine.change).to include({:denomination=>0.50, :amount=>6})
    end

    it 'Does not allow a user to purchase non existent items' do
      machine.restock
      expect(machine.purchase("Quavers", [0.50])).to eq("No such item")
    end

    it 'Does not allow a user to purchase out of stock items' do
      machine.restock
      machine.reload_change
      5.times do
        machine.purchase("Pringles", [0.50, 0.10])
      end
      expect(machine.purchase("Pringles", [0.50, 0.10])).to eq("Out of stock")
    end

    it 'Informs a user if not enough money inserted' do
      machine.restock
      expect(machine.purchase("Cheetos", [0.10, 0.10])).to eq("Insufficient funds")
    end
  end

  describe '#give_change' do
    it 'Returns the fewest amount of coins due in change' do
      machine.reload_change
      due = 0.7
      expect(machine.give_change).to eq([0.5, 0.2])
    end
  end
end
