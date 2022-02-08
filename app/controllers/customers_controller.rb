require_relative "../views/customers_view"
require_relative "../models/customer"

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def add
    # Ask VIEW to ask user for a name
    name = @customers_view.ask_for("name")
    # Ask VIEW to ask user for a address
    address = @customers_view.ask_for("address")
    # Ask CUSTOMER for an instance
    new_customer = Customer.new(name: name, address: address)
    # Ask REPO to store it
    @customer_repository.create(new_customer)
  end

  def list
    # Ask REPO for customers
    customers = @customer_repository.all
    # Ask VIEW to display them
    @customers_view.display(customers)
  end
end
