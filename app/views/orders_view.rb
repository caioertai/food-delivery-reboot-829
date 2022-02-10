class OrdersView
  def ask_for_index
    puts "Which one (choose by number)?"
    gets.chomp.to_i - 1
  end

  def display(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1}. #{order.meal.name} - #{order.customer.name} - #{order.employee.username}"
    end
  end
end
