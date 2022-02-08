class Router
  def initialize(meals_controller, customers_controller)
    @running = true
    @meals_controller = meals_controller
    @customers_controller = customers_controller
  end

  def run
    while @running
      puts "1. To add a meal"
      puts "2. To list all meals"
      puts "3. To add a customer"
      puts "4. To list all customers"
      puts "0. Quit"
      user_input = gets.chomp.to_i
      print `clear`
      case user_input
      when 1 then @meals_controller.add
      when 2 then @meals_controller.list
      when 3 then @customers_controller.add
      when 4 then @customers_controller.list # "customers#list"
      when 0 then @running = false
      end
      puts "---"
    end
  end
end
