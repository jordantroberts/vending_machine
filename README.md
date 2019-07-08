# Vending Machine

## Acceptance Criteria

Build a vending machine that behaves as follows:

* Once an item is selected and the appropriate amount of money is inserted, the vending machine should return the correct product.

* It should also return change if too much money is provided, or ask for more money if insufficient funds have been inserted.

* The machine should take an initial load of products and change. The change will be of denominations 1p, 2p, 5p, 10p, 20p, 50p, £1 and £2.

* There should be a way of reloading either products or change at a later point.

* The machine should keep track of the products or change that it contains.

## User stories

```
As a hungry person
So that I can have a snack whenever I want
I would like to be able to buy food from a vending machine.

As a hungry person
So that I make sure I don't lose money when snacking
I would like the vending machine to return any change I am due.

As a hungry person
So that I can definitely get the snack of my choice
I would like to be informed if I have not put in enough money.

As a vending machine owner
So that I can keep track of my vending machine
I would like to know what products and change are currently in my machine.

As a vending machine owner
So that I can keep the vending machine stocked up
I would like to be able to reload the products and change when I want to.
```

Extra
```
As a vending machine owner
So that the selection of products doesn't get boring
I would like to add brand new products to the machine.
```

## Installing this program

1. Clone this repo
2. `cd` into the directory in your terminal
3. Run `bundle install`

## Running this program

Example of how you would run this program from your command line:

```
> irb
> require './lib/vending_machine'
> machine = Vending_Machine.new
```
The machine should take an initial load of products and change. The change is stored in denominations of pence:

```
> machine.reload_change
> machine.restock

```

Vending machine is ready to go! You can purchase an item by calling the `dispense` method, passing the name of the item and the coins you insert as an argument. Here I want to buy a tube of Pringles with a 50p and a 20p.

```
> machine.dispense("Pringles", [50, 20])
=> [10]
```
The vending machine will return the correct amount of change in the fewest amount of coins (depending which coins are available in the machine)

I now have 10p left. I'll try and buy some Cheetos.
```
> machine.dispense("Pringles", [10])
=> "Insufficient funds"
```
The vending machine tells me I don't have enough. Oh well.

The vending machine knows how much change and what products it has at any time. To find out:

```
machine.items
machine.change
```

These can be reloaded or restocked at any time using the above `reload_change` and `restock` methods. However, if you own the vending machine and want to add some brand new products in, you can do this as follows. First, create a new instance of the Product class and give it a name and a price. Then pass it in as an argument to the vending machine's `update_stock` method, along with the quantity.

```
new_snack = Product.new
new_snack.set_name("Doritos")
new_snack.set_price(50)
machine.update_stock(new_snack, 20)
```

## Testing this program

Run `rspec` from the command line. This program has 100% test coverage! :)

## My approach

I initially spent time diagramming out how this program would run and what the Vending Machine class would be responsible for:

<div align="center">
    <img src="Plan1.png" width="600px"</img>
</div>

The most challenging aspect was making sure the most sensible denominations of change were given (i.e. the fewest coins) and only if those coins were available. When I reached this part, I spent time planning how I would like this method to work:

<div align="center">
    <img src="Plan2.png" width="600px"</img>
</div>

I initially decided to just have one class, the Vending Machine class. This is because I believe that a vending machine object would contain products and coins and it would be able to dispense and update these variables. I didn't think another class was necessary.

However, I later decided that I would like to implement an update_stock method so that new items could be added to the vending machine. I thought this would be a better in the real world if a vending machine owner were to sell this product and the stock wouldn't always be crisps. It might be vegan snacks, for example. I didn't think that the Vending Machine class should be responsible for creating these new items so I made a Product class so that new items can be inputted.

One other change I made was how I stored the denominations. I was storing these initially as decimals (e.g. 0.2 for 20p, 1.0 for £1 etc) but it became unnecessarily complex when doing the calculations, which I was doing in pence. Therefore I updated the hash so that the change is now stored as pence.

If I were to spend longer on this task, I would like to:

* Refactor the tests to unit tests and feature tests
* Test for more edge cases

## Author
Jordan Roberts
