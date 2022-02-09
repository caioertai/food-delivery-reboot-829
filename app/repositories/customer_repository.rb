require "csv"
require_relative "../models/customer"
require_relative "base_repository"

class CustomerRepository < BaseRepository
  def repo_class
    Customer
  end

  private

  def load_csv
    CSV.foreach(@csv_path, headers: true, header_converters: :symbol) do |row|
      # Type casting
      row[:id] = row[:id].to_i

      @elements << Customer.new(
        id: row[:id],
        name: row[:name],
        address: row[:address]
      )
    end
  end
end
