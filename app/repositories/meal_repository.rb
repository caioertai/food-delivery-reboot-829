require "csv"
require_relative "../models/meal"
require_relative "base_repository"

class MealRepository < BaseRepository
  private

  def update_csv
    CSV.open(@csv_path, "wb") do |csv|
      csv << %w[id name price] # <----- id name price
      @models.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_path, headers: true, header_converters: :symbol) do |row|
      # Type casting
      # row => { id: "1", price: "10", ... }
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      # row => { id: 1, price: 10, ... }

      @models << Meal.new(
        id: row[:id],
        name: row[:name],
        price: row[:price]
      )
    end
  end
end
