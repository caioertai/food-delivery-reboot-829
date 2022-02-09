# require "pry-byebug"
require_relative "app/repositories/employee_repository"
require_relative "app/controllers/sessions_controller"

employee_repository = EmployeeRepository.new("data/employees.csv")
sessions_controller = SessionsController.new(employee_repository)

sessions_controller.login
