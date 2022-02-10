require "csv"
require_relative "../models/order"

class OrderRepository
  def initialize(csv_path, meal_repository, customer_repository, employee_repository)
    @csv_path = csv_path
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = []

    load_csv if File.exist?(@csv_path)
  end

  def all
    @orders
  end

  def mark_as_delivered(id)
    find(id).deliver!
    update_csv
  end

  def undelivered_orders
    all.reject { |order| order.delivered? }
  end

  def undelivered_from(employee)
    undelivered_orders.select do |order|
      order.employee == employee
    end
  end

  def create(order)
    order.id = next_id
    @orders << order
    order.employee.add_order(order)

    update_csv
  end

  def find(id)
    @orders.find { |order| order.id == id } # order instance
  end

  private

  def next_id
    @orders.empty? ? 1 : @orders.last.id + 1
  end

  def update_csv
    CSV.open(@csv_path, "wb") do |csv|
      csv << %w[id delivered meal_id customer_id employee_id]
      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_path, headers: true, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      row[:meal_id] = row[:meal_id].to_i
      row[:customer_id] = row[:customer_id].to_i
      row[:employee_id] = row[:employee_id].to_i
      row[:delivered] = row[:delivered] == "true"
      employee = @employee_repository.find(row[:employee_id])
      order = Order.new(
        id: row[:id],
        delivered: row[:delivered],
        meal: @meal_repository.find(row[:meal_id]),
        customer: @customer_repository.find(row[:customer_id]),
        employee: employee,
      )
      employee.add_order(order)

      @orders << order
    end
  end
end
