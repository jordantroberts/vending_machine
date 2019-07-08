require 'vending_machine'

describe Vending_Machine do

  let(:machine) { described_class.new }

  describe '#restock' do
    it 'Products are reloaded' do
      expect(machine.restock).to include({:name=>"Cheetos", :price=>50, :quantity=>10})
    end
  end

  describe '#update_stock' do
    let(:product) { double :product, :name => "Doritos", :price => 50 }
    it 'Allows new stock to be added' do
      expect(machine.update_stock(product, 5)).to include({:name=>"Doritos", :price=>50, :quantity=>5})
    end
  end

  describe '#reload_change' do
    it 'Change is reloaded' do
      expect(machine.reload_change).to include({:denomination=>100, :amount=>5})
    end
  end

  describe '#purchase' do
    it 'Items can be purchased from vending machine' do
      machine.restock
      machine.reload_change
      machine.dispense("Cheetos", [50])
      expect(machine.restock).to include({:name=>"Cheetos", :price=>50, :quantity=>10})
    end

    it 'Adds money for item to vending machine change' do
      machine.restock
      machine.reload_change
      machine.dispense("Pringles", [50, 10])
      expect(machine.change).to include({:denomination=>50, :amount=>6})
    end

    it 'Does not allow a user to purchase non-existent items' do
      machine.restock
      expect(machine.dispense("Quavers", [50])).to eq("No such item")
    end

    it 'Does not allow a user to dispense out of stock items' do
      machine.restock
      machine.reload_change
      5.times do
        machine.dispense("Pringles", [50, 10])
      end
      expect(machine.dispense("Pringles", [50, 10])).to eq("Out of stock")
    end

    it 'Informs a user if not enough money inserted' do
      machine.restock
      expect(machine.dispense("Cheetos", [10, 10])).to eq("Insufficient funds")
      expect(machine.dispense("Pringles", [20, 10])).to eq("Insufficient funds")
    end

    it 'Returns the fewest amount of coins due in change' do
      machine.reload_change
      machine.restock
      expect(machine.dispense("Pringles", [100, 10, 20])).to eq([50, 20])
      expect(machine.dispense("Pringles", [50, 20])).to eq([10])
      expect(machine.dispense("Cheetos", [200])).to eq([100, 50])
    end

    it 'Only returns the coins if they are in the machine' do
      machine.reload_change
      machine.restock
      expect(machine.dispense("Pringles", [100, 100, 100, 100, 100, 100])).to eq([200, 100, 100, 100, 20, 20])
    end
  end
end
