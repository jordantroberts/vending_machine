require 'vending_machine'

describe Vending_Machine do

  let(:machine) { described_class.new }

  describe '#restock' do
    it 'Products are reloaded' do
      expect(machine.restock).to include({:name=>"Cheetos", :price=>0.5, :quantity=>10})
    end
  end

  describe '#update_stock' do
    let(:product) { double :product, :name => "Doritos", :price => 0.5 }
    it 'Allows new stock to be added' do
      expect(machine.update_stock(product, 5)).to include({:name=>"Doritos", :price=>0.5, :quantity=>5})
    end
  end

  describe '#reload_change' do
    it 'Change is reloaded' do
      expect(machine.reload_change).to include({:denomination=>1.00, :amount=>5})
    end
  end

  describe '#purchase' do
    it 'Items can be purchased from vending machine' do
      machine.restock
      machine.reload_change
      machine.dispense("Cheetos", [0.50])
      expect(machine.restock).to include({:name=>"Cheetos", :price=>0.5, :quantity=>10})
    end

    it 'Adds money for item to vending machine change' do
      machine.restock
      machine.reload_change
      machine.dispense("Pringles", [0.50, 0.10])
      expect(machine.change).to include({:denomination=>0.50, :amount=>6})
    end

    it 'Does not allow a user to purchase non existent items' do
      machine.restock
      expect(machine.dispense("Quavers", [0.50])).to eq("No such item")
    end

    it 'Does not allow a user to dispense out of stock items' do
      machine.restock
      machine.reload_change
      5.times do
        machine.dispense("Pringles", [0.50, 0.10])
      end
      expect(machine.dispense("Pringles", [0.50, 0.10])).to eq("Out of stock")
    end

    it 'Informs a user if not enough money inserted' do
      machine.restock
      expect(machine.dispense("Cheetos", [0.10, 0.10])).to eq("Insufficient funds")
    end

    it 'Returns the fewest amount of coins due in change' do
      machine.reload_change
      machine.restock
      expect(machine.dispense("Pringles", [1.00, 0.10, 0.20])).to eq([0.5, 0.2])
    end

    it 'Only returns the coins if they are in the machine' do
      machine.reload_change
      machine.restock
      expect(machine.dispense("Pringles", [1.00, 1.00, 1.00, 1.00, 1.00, 1.00])).to eq([2.00, 1.00, 1.00, 1.00, 0.20, 0.20])
    end

  end
end
