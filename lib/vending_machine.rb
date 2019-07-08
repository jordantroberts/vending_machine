class Vending_Machine

  attr_reader :change, :items, :coins

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

  def purchase(item, coins = [])
    @coins = coins
    item = @items.find { |product| product[:name] == item }
    return "No such item" if item == nil
    return "Out of stock" if item[:quantity] == 0
    return "Insufficient funds" if coins.reduce(:+) < item[:price]
    item[:quantity] -= 1
    update_money
    return @items
  end

  def give_change
    due = 0.7
    change_calculated = []
    @change.reverse.each do |x|
      money = due / x[:denomination]
      if money >= 1
      n = money.to_i
      n.times { change_calculated << x[:denomination] }
      due -= (n * x[:denomination])
      due = due.round(1)
      end
    end
    return change_calculated
  end

  private
  def update_money
    @coins.each do |coin|
      current_denomination = @change.find { |x| x[:denomination] == coin }
      current_denomination[:amount] += 1
    end
  end

  def calculate_change

  end
end

  # Iterate over hash backwards working out the mod
  # e.g. 0.3/2 = 0 until it's 1 so 30/20 = 1
  # store that 1 20p as change to do
  # 30%20 = 10
  # 10/2 ...
