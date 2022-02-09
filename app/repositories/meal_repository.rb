require "csv"
require_relative "../models/meal"
require_relative "base_repository"

class MealRepository < BaseRepository
  def repo_class
    Meal
  end

  private

  def load_csv
    CSV.foreach(@csv_path, headers: true, header_converters: :symbol) do |row|
      @elements << Meal.new(
        id: row[:id],
        name: row[:name],
        price: row[:price]
      )
    end
  end
end
