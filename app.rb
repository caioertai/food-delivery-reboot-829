# require "pry-byebug"
require_relative "router"

require_relative "app/repositories/meal_repository"
require_relative "app/repositories/customer_repository"
require_relative "app/repositories/employee_repository"

require_relative "app/controllers/meals_controller"
require_relative "app/controllers/customers_controller"
require_relative "app/controllers/sessions_controller"

meal_repository = MealRepository.new("data/meals.csv")
customer_repository = CustomerRepository.new("data/customers.csv")
employee_repository = EmployeeRepository.new("data/employees.csv")

meals_controller = MealsController.new(meal_repository)
customers_controller = CustomersController.new(customer_repository)
sessions_controller = SessionsController.new(employee_repository)

router = Router.new(meals_controller, customers_controller, sessions_controller)
router.run
