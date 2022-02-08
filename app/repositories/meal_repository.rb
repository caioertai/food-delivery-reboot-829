require "csv"
require_relative "../models/meal"

class MealRepository
  def initialize(csv_path)
    @csv_path = csv_path
    @meals = []

    load_csv if File.exist?(@csv_path)
  end

  def all
    @meals
  end

  def create(meal)
    meal.id = next_id
    @meals << meal

    update_csv
  end

  def find(id)
    @meals.find { |meal| meal.id == id } # meal instance
  end

  private

  def next_id
    @meals.empty? ? 1 : @meals.last.id + 1
  end

  def update_csv
    CSV.open(@csv_path, "wb") do |csv|
      csv << %w[id name price]
      @meals.each do |meal|
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

      @meals << Meal.new(
        id: row[:id],
        name: row[:name],
        price: row[:price]
      )
    end
  end
end
