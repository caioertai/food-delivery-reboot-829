require_relative "../views/meals_view"
require_relative "../models/meal"

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def add
    # Ask VIEW to ask user for a name
    name = @meals_view.ask_for("name")
    # Ask VIEW to ask user for a price
    price = @meals_view.ask_for("price").to_i
    # Ask MEAL to instantiate a new meal
    meal = Meal.new(name: name, price: price)
    # Ask REPO to store it
    @meal_repository.create(meal)
  end

  def list
    # Ask REPO for meals
    all_meals = @meal_repository.all
    # Ask VIEW to display them
    @meals_view.display(all_meals)
  end
end
