require "pry-byebug"
require_relative "app/models/order"
require_relative "app/models/meal"
require_relative "app/models/employee"
require_relative "app/models/customer"

ringo = Employee.new(username: "ringo")
john = Customer.new(name: "John")
caipirinha = Meal.new(name: "Caipirinha", price: 12)
order1 = Order.new

p order1
