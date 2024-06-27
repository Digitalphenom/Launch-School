

#------------------------------------

# The following is a short description of an application that lets a customer place an order for a meal:

# - A meal always has three meal items: a burger, a side, and drink.
# - For each meal item, the customer must choose an option.
# - The application must compute the total cost of the order.

# 1. Identify the nouns and verbs we need in order to model our classes and methods.
# 2. Create an outline in code (a spike) of the structure of this application.
# 3. Place methods in the appropriate classes to correspond with various verbs.
#------------------------------------------
=begin
Nouns
  □ Customer
  □ Application
  □ meal 
    □ Total Order
    ﹥ burger, a side, and drink.

Verbs
  □ Choose
  □ Compute cost

State
  □ Total Cost
  
=end

module BurgerMenu
  def burger_price(item)
    item = item.downcase
    if item.match?('large')
      12.99
    elsif item.match?('medium')
      9.99
    elsif item.match?('small')
      7.99
    end
  end

  def drink_price(item)
    item = item.downcase
    if item.match?('large')
      3.79
    elsif item.match?('medium')
      2.99
    elsif item.match?('small')
      1.99
    end
  end
  
  def side_price(item)
    item = item.downcase
    if item.match?('large')
      6.99
    elsif item.match?('medium')
      4.99
    elsif item.match?('small')
      3.99
    end
  end
end

module SeaFoodMenu;end
module OrganicMenu;end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧

class Customer
  attr_reader :main, :side, :drink, :receipt

  def initialize(name, order)
    @name = name
    @main, @side, @drink = order
  end

  def go_to_register
    @receipt = Application.new([main, side, drink])
  end

  def check_total_order
    puts "You Ordered:\n----\n"
    puts "#{main} $#{receipt.main}"
    puts "#{side} $#{receipt.side}"
    puts "#{drink} $#{receipt.drink}\n---"
    puts "Yor total is: $#{receipt.total_price}"
  end

  def to_s
    "Welcome To Fluffy Burger #{@name}!"
  end
end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
class Application
  attr_reader :total_price, :main, :drink, :side

  include BurgerMenu
  include SeaFoodMenu
  include OrganicMenu

  def initialize(order)
    @total_price = 0
    @main = 0
    @drink = 0
    @side = 0
    compute_cost(order)
  end

  def compute_cost(order)
    order.each do |item|
      item = item.downcase
      if item.include?('burger')
        add_main_meal(item)
      elsif item.include?('fries')
        add_side_meal(item)
      elsif item.include?('drink')
        add_drink_meal(item)
      end
    end
  end
  vsdl
  def add_main_meal(item)
    #can check (menu type) based on meal chosen to extend code
      @total_price += burger_price(item)
      @main += burger_price(item)
  end

  def add_side_meal(item)
    @total_price += side_price(item)
    @side += side_price(item)
  end

  def add_drink_meal(item)
    @total_price += drink_price(item)
    @drink += drink_price(item)
  end
end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
order = ['Large Burger', 'Medium Fries', 'Large Drink']
joe = Customer.new('Joe', order)
puts joe
joe.go_to_register
joe.check_total_order

# This program begins by instantiating a new customer object which picks the items the customer wishes to order.
# The customer then symbolicly goes to the register, where `Customer` collaborate with `Application` to calculate the cost of the meal.
# Calling the `go_to_register` method instantiates a new `Application` instance which which sets the initial state of each item to 0 and executes the `compute_cost` method.
# When we compute the cost of each item, we invoke `add_burger` `add_fries` etc.. which abstracts the incrementing of `total_price` and each `item` price, to be used in collaboration with the customers receipt display in the `Customer` class. The application class accesses the price of each menu item by importing several `Menu` modules from different restaurants.
