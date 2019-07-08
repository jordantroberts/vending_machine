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
              { :denomination => 2.00, :amount => 1 }
    ]
  end

  def purchase(item, coins = [])
    @coins = coins
    item = @items.find { |product| product[:name] == item }
    return "No such item" if item == nil
    return "Out of stock" if item[:quantity] == 0
    return "Insufficient funds" if coins.reduce(:+) < item[:price]
    item[:quantity] -= 1
    change_due = coins.reduce(:+) - item[:price]
    update_money
    give_change(change_due)
  end

  private
  def give_change(amount_due)
    change_calculated = []
    @change.reverse.each do |x|
      if x[:denomination] <= amount_due
        coin_num = (amount_due / x[:denomination]).to_i
        coin_num.times {
          if x[:amount] > 0
            x[:amount] -= 1
            change_calculated << x[:denomination]
            amount_due -= x[:denomination]
          end
        }
      end
    end
    return change_calculated
  end

  def update_money
    @coins.each do |coin|
      current_denomination = @change.find { |x| x[:denomination] == coin }
      current_denomination[:amount] += 1
    end
  end
end
