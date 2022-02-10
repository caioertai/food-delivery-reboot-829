class EmployeesView
  def display(employees)
    employees.each_with_index do |employees, index|
      puts "#{index + 1}. #{employees.username}"
    end
  end
end
