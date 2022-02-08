require "csv"
require_relative "../models/customer"
require_relative "base_repository"

class CustomerRepository < BaseRepository
  private

  def update_csv
    CSV.open(@csv_path, "wb") do |csv|
      csv << %w[id name address]
      @models.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end


  def load_csv
    CSV.foreach(@csv_path, headers: true, header_converters: :symbol) do |row|
      # Type casting
      row[:id] = row[:id].to_i

      @models << Customer.new(
        id: row[:id],
        name: row[:name],
        address: row[:address]
      )
    end
  end
end
