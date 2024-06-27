## STORE INVENTORY MANAGEMENT SYSTEM
# You are tasked with implementing a program that simulates a basic inventory management system for a small store. The store has a limited number of items in stock, and the system should allow for adding items to the inventory, updating the stock levels, and retrieving the current stock levels for each item.

# Your program should have the following functionalities:
# Add an item to the inventory: Allow the USER to input the name, price, and initial stock level for a new item, and add it to the inventory. 
# Update stock levels: Allow the user to update the stock level of an existing item in the inventory by specifying the item name and the new stock level.
# Retrieve stock levels: Allow the user to retrieve the current stock level for a specific item in the inventory by specifying the item name.

=begin

 Verbs
▣ User => User actions are interfaced through app
  □ Abilitites
    ﹥ add to stock ie [{name, price, qty}]
    ﹥ update stock => name, price or qty
    ﹥ retrieve stock => name, price or qty

▣ Store => store contains stock
  □ stock 
    ﹥ name
    ﹥ price
    ﹥ qty

▣ Where does the stores initial stock come from?
  □ Start with empty stock
    ﹥ @stock => empty collection

Initial spike
    module ManageStock
  def add_item
  end

  def update_stock
  end

  def retrieve
  end
end

class Store
  def initialize
    @invetory = []
  end
end

class Employee < Store
  include ManageStock

  def initialize(name, id)
    @name = name
    @id = id
  end
end

katie = employee.new('name', '125')
josh = employee.new

=end

module App

  def add_item(name, price, qty)
    hsh = {}
    hsh[name] = [['price',price], ['qty', qty]].to_h
    inventory << hsh
    puts "  => You added #{hsh[name]['qty']} #{hsh.key(hsh[name])}'s"
  end

  def update_stock(name, qty)
    inventory.each do |category|
      if category[name]
        category[name]['qty'] += qty
        return display_new_stock_level 
      end
    end
    puts "#{name} is not in the system"
  end

  def retrieve_stock_levels(name)
    return 'The stock is currently empty' if inventory.empty?
    inventory.each { |category| return display_stock_levels(name, category) if category[name] }
    'None in Stock'
  end

  def display_new_stock_level()
    puts 'you updated stock'
  end

  def display_stock_levels(name, category)
    stock = category[name]['qty']
    "We currently have #{stock} #{name}'s in stock."
  end
end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
class Store
  attr_reader :inventory

  include App

  def initialize(name)
    @store_name = name
    @inventory = []
  end
end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
class Employee
  attr_reader :name, :store

  def initialize(name, employee_id)
    @store = Store.new('Aquarium')
    @name = name
    @employee_id = employee_id
  end
end
#‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
josh = Employee.new('Josh', 124)

josh.store.add_item('Spiky Ball', 2.99, 100)
josh.store.add_item('Boss Bones', 6.97, 27)
josh.store.add_item('Aqua Laguna Tank', 1066, 3)

p josh.store.retrieve_stock_levels('Spiky Ball')
p josh.store.retrieve_stock_levels('Aqua Laguna Tank')

josh.store.update_stock('Aqua Lagna Tank', 4)

p josh.store.retrieve_stock_levels('Aqua Laguna Tank')


# require 'pry'
# 
# module ManageStock
# 
#   def add_item(name, price, qty)
#     hsh = {}
#     hsh[name] = [['price',price], ['qty', qty]].to_h
#     petco.inventory << hsh
#     puts "You added #{hsh[name]['qty']} #{hsh.key(hsh[name])}'s"
#   end
# 
#   def update_stock(name, qty)
#     petco.inventory.each do |category|
#       if category[name]
#         category[name]['qty'] += qty
#         return display_new_stock_level 
#       end
#     end
#     puts "#{name} is not in the system"
#   end
# 
#   def retrieve_stock_levels(name)
#     return 'The stock is currently empty' if petco.inventory.empty?
#     petco.inventory.each { |category| return display_stock_levels(name, # category) if category[name] }
#     'None in Stock'
#   end
# 
#   def display_new_stock_level()
#     puts 'you updated stock'
#   end
# 
#   def display_stock_levels(name, category)
#     stock = category[name]['qty']
#     "We currently have #{stock} #{name}'s in stock."
#   end
# end
# 
# #‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
# 
# class Warehouse
#   attr_reader :inventory
# 
#   def initialize
#     @inventory = []
#   end
# end
# 
# #‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
# 
# class Petco < Warehouse;end
# class Target < Warehouse;end
# class Safeway < Warehouse;end
# 
# #‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
# 
# class Employee
#   attr_reader :name, :petco
#   include ManageStock
# 
#   def initialize(name, employee_id)
#     @petco = Petco.new
#     @name = name
#     @employee_id = employee_id
#   end
# end
# 
# #‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧‧
# 
# josh = Employee.new('Josh', 124)
# 
# josh.add_item('Spiky Ball', 2.99, 100)
# p josh.retrieve_stock_levels('Spiky Ball')
# 
# josh.add_item('Boss Bones', 6.97, 27)
# josh.add_item('Aqua Laguna Tank', 1066, 3)
# 
# p josh.retrieve_stock_levels('Aqua Laguna Tank')
# 
# josh.update_stock('Aqua Lagna Tank', 4)
# 
# p josh.retrieve_stock_levels('Aqua Laguna Tank')
