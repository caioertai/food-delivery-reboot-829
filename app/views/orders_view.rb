class OrdersView
  def ask_for_index
    puts "Which one (choose by number)?"
    gets.chomp.to_i - 1
  end
end
