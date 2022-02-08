class BaseView
  def ask_for(string)
    puts "#{string.capitalize}?"
    gets.chomp
  end
end
