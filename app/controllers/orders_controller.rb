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

  def mark_as_delivered(current_user)
    @orders_view.display(current_user.undelivered_orders)
    # Ask OrdersView for and index
    order_index = @orders_view.ask_for_index
    # Ask Array for order
    order = orders[order_index]
    # Ask OrderRepo to mark the order as delivered
    @order_repository.mark_as_delivered(order.id)
  end

  def list_my_orders(current_user)
    @orders_view.display(current_user.undelivered_orders)
  end

  # def list_my_orders(current_user)
  #   # Ask OrderRepo for orders from me?
  #   orders = @order_repository.undelivered_from(current_user)
  #   # Ask OrdersView to display them
  #   @orders_view.display(orders)
  # end

  def method_name

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

  def list_undelivered_orders
    # Ask OrderRepo for undelivered orders
    undelivered_orders = @order_repository.undelivered_orders
    # Ask OrdersView to display them
    @orders_view.display(undelivered_orders)
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
