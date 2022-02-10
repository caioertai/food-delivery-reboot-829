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

  def create(order)
    order.id = next_id
    @orders << order

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
      # convert row into an Order instance
      # row => {:id=>"1", :deliver=>"true",
      #         :meal_id=>"2", :employee_id=>"2", :customer_id=>"1"}
      # Typecasting
      row[:id] = row[:id].to_i
      row[:meal_id] = row[:meal_id].to_i
      row[:customer_id] = row[:customer_id].to_i
      row[:employee_id] = row[:employee_id].to_i
      row[:delivered] = row[:delivered] == "true"

      order = Order.new(
        id: row[:id],
        delivered: row[:delivered],
        meal: @meal_repository.find(row[:meal_id]),
        customer: @customer_repository.find(row[:customer_id]),
        employee: @employee_repository.find(row[:employee_id]),
      )

      @orders << order
    end
  end
end
