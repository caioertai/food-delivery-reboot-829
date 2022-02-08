require "csv"
require_relative "../models/customer"

class CustomerRepository
  def initialize(csv_path)
    @csv_path = csv_path
    @customers = []

    load_csv if File.exist?(@csv_path)
  end

  def all
    @customers
  end

  def create(customer)
    customer.id = next_id
    @customers << customer

    update_csv
  end

  def find(id)
    @customers.find { |customer| customer.id == id } # customer instance
  end

  private

  def next_id
    @customers.empty? ? 1 : @customers.last.id + 1
  end

  def update_csv
    CSV.open(@csv_path, "wb") do |csv|
      csv << %w[id name address]
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end


  def load_csv
    CSV.foreach(@csv_path, headers: true, header_converters: :symbol) do |row|
      # Type casting
      row[:id] = row[:id].to_i

      @customers << Customer.new(
        id: row[:id],
        name: row[:name],
        address: row[:address]
      )
    end
  end
end
