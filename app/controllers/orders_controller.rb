require_relative "../views/orders_view"
require_relative "../views/meals_view"
require_relative "../views/customers_view"
require_relative "../views/employees_view"

class OrdersController
  def initialize(order_repository, meal_repository, customer_repository, employee_repository)
    @order_repository = order_repository
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @employees_view = EmployeesView.new
  end

  def add
    order_meal = get_meal
    order_customer = get_customer

    # Ask EmployeeRepo for riders
    riders = @employee_repository.riders
    # Ask EmployeesView to display riders
    @employees_view.display(riders)
    # Ask OrdersView for an index
    rider_index = @orders_view.ask_for_index
    # Ask riders Array for the instance
    order_employee = riders[rider_index]

    # Ask Order to instantiate an instance with this info
    order = Order.new(
      meal: order_meal,
      customer: order_customer,
      employee: order_employee
    )
    # Ask OrderRepo to store it
    @order_repository.create(order)
  end

  private

  def get_meal
    # Ask MealRepo for all meals
    meals = @meal_repository.all
    # Ask MealsView to display meals
    @meals_view.display(meals)
    # Ask OrdersView for an index
    meal_index = @orders_view.ask_for_index
    # Ask meals Array for the instance
    meals[meal_index]
  end

  def get_customer
    # Ask CustomerRepo for all customers
    customers = @customer_repository.all
    # Ask CustomersView to display customers
    @customers_view.display(customers)
    # Ask OrdersView for an index
    customer_index = @orders_view.ask_for_index
    # Ask customers Array for the instance
    customers[customer_index]
  end
end
