class SessionsView
  def ask_for(string)
    puts "#{string.capitalize}?"
    gets.chomp
  end

  def greet(employee)
    puts "Welcome, #{employee.username}!"
  end

  def login_error
    puts "Username and/or password incorrect!"
  end
end
