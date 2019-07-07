class Vending_Machine

  attr_reader :change, :items

  def initialize
    @change = {}
    @items = {}
  end

  def restock(price, item)
    @items = { 0.5 => "pringles" }
  end

end
