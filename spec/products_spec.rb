require 'products'

describe Products do

  let(:product) { described_class.new }

  describe '#set_name' do
    it 'Sets the name of a new product' do
      expect(product.set_name("Doritos")).to eq "Doritos"
    end
  end

  describe '#set_price' do
    it 'Sets the price of a new product' do
      expect(product.set_price(70)).to eq 70
    end
  end
end
