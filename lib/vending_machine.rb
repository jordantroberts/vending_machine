class Vending_Machine

  attr_reader :change, :items

  def initialize(items = [], change = 0)
    @items = items
    @change = change
  end

  def restock
    @items = [
            {:name=>"Cheetos", :quantity=>10, :price=>0.50},
            {:name=>"Pringles", :quantity=>5, :price=>0.60}
            ]
  end

  def purchase(item, coins)
    item = @items.find { |product| product[:name] == item }
    return "No such item" if item == nil
    return "Out of stock" if item[:quantity] == 0
    return "Insufficient funds" if coins < item[:price]
    item[:quantity] -= 1
    @change += item[:price]
    return @items
  end
end
