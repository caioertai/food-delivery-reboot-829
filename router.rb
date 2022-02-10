class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @running = true
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @current_user = nil
  end

  def run
    while @running
      @current_user = @sessions_controller.login until @current_user
      @current_user.manager? ? manager_session : rider_session
      puts "---"
    end
  end

  private

  def manager_session
    display_manager_menu
    user_input = gets.chomp.to_i
    print `clear`
    dispatch_manager(user_input)
  end

  def rider_session
    display_rider_menu
    user_input = gets.chomp.to_i
    print `clear`
    dispatch_rider(user_input)
  end

  def display_rider_menu
    puts "1. To mark an order of mine as delivered"
    puts "2. To list all of my undelivered orders"
    puts "0. Quit"
  end

  def display_manager_menu
    puts "1. To add a meal"
    puts "2. To list all meals"
    puts "3. To add a customer"
    puts "4. To list all customers"
    puts "5. To add an order"
    puts "6. To list undelivered orders"
    puts "0. Quit"
  end

  def dispatch_rider(user_input)
    case user_input
    when 1 then @orders_controller.mark_as_delivered(@current_user)
    when 2 then @orders_controller.list_my_orders(@current_user)
    when 0 then @running = false
    end
  end

  def dispatch_manager(user_input)
    case user_input
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered_orders
    when 0 then @running = false
    end
  end
end
