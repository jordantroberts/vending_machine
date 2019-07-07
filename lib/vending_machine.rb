class Vending_Machine

  attr_reader :change, :items

  def initialize(items = [], change = [])
    @items = items
    @change = change
  end

  def restock
    @items = [
            { :name=>"Cheetos", :quantity=>10, :price=>0.50 },
            { :name=>"Pringles", :quantity=>5, :price=>0.60 }
            ]
  end

  def reload_change
    @change = [
              { :denomination => 0.01, :amount => 5 },
              { :denomination => 0.02, :amount => 5 },
              { :denomination => 0.05, :amount => 5 },
              { :denomination => 0.10, :amount => 5 },
              { :denomination => 0.20, :amount => 5 },
              { :denomination => 0.50, :amount => 5 },
              { :denomination => 1.00, :amount => 5 },
              { :denomination => 2.00, :amount => 5 }
    ]
  end

  def purchase(item, coins)
    item = @items.find { |product| product[:name] == item }
    return "No such item" if item == nil
    return "Out of stock" if item[:quantity] == 0
    return "Insufficient funds" if coins < item[:price]
    item[:quantity] -= 1
    #@change += item[:price]
    return @items
  end
end
