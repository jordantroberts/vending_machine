require_relative 'vending_machine'

class Product

  attr_reader :name, :price

  def set_name(name)
    @name = name
  end

  def set_price(price)
    @price = price
  end

end
