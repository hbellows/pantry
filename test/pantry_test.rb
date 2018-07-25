require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/recipe'

class PantryTest < Minitest::Test

  def test_it_exists
    # skip
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
  end

  def test_a_pantry_starts_with_no_stock
    # skip
    pantry = Pantry.new

    assert_equal ({}), pantry.stock
  end

  def test_it_can_check_stock_of_items
    # skip
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check('Cheese')
  end

  def test_it_can_restock_pantry_items
    # skip
    pantry = Pantry.new

    pantry.restock("Cheese", 10)
    assert_equal 10, pantry.stock_check("Cheese")

    pantry.restock("Cheese", 20)
    assert_equal 30, pantry.stock_check("Cheese")
  end

  def test_a_shopping_list_starts_empty
    # skip
    pantry = Pantry.new

    assert_equal ({}), pantry.shopping_list
  end

  def test_it_can_add_one_recipe_to_a_shopping_list
    # skip
    pantry = Pantry.new

    recipe = Recipe.new("Cheese Pizza")
    recipe.add_ingredient("Cheese", 20)
    recipe.add_ingredient("Flour", 20)

    pantry.add_to_shopping_list(recipe)
    assert_equal ({"Cheese" => 20, "Flour" => 20}), pantry.shopping_list
  end

  def test_it_can_add_another_recipe_to_a_shopping_list
    # skip
    pantry = Pantry.new

    recipe_1  = Recipe.new("Cheese Pizza")
    recipe_1.add_ingredient("Cheese", 20)
    recipe_1.add_ingredient("Flour", 20)

    pantry.add_to_shopping_list(recipe_1)
    assert_equal ({"Cheese" => 20, "Flour" => 20}), pantry.shopping_list

    recipe_2 = Recipe.new("Spaghetti")
    recipe_2.add_ingredient("Spaghetti Noodles", 10)
    recipe_2.add_ingredient("Marinara Sauce", 10)
    recipe_2.add_ingredient("Cheese", 5)

    pantry.add_to_shopping_list(recipe_2)
    result = ({"Cheese" => 25, "Flour" => 20, "Spaghetti Noodles" => 10, "Marinara Sauce" => 10})
    assert_equal result, pantry.shopping_list
  end

  def test_it_can_print_a_shopping_list
    # skip
    pantry = Pantry.new

    recipe_1  = Recipe.new("Cheese Pizza")
    recipe_1.add_ingredient("Cheese", 20)
    recipe_1.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(recipe_1)

    recipe_2 = Recipe.new("Spaghetti")
    recipe_2.add_ingredient("Spaghetti Noodles", 10)
    recipe_2.add_ingredient("Marinara Sauce", 10)
    recipe_2.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(recipe_2)

    result = "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"

    assert_equal result, pantry.print_shopping_list
  end

  def test_a_cookbook_starts_with_no_recipes
    # skip
    pantry = Pantry.new

    assert_equal [], pantry.cookbook
  end

  def test_it_can_add_recipes_to_a_cookbook
    # skip
    pantry = Pantry.new

    recipe_1 = Recipe.new("Cheese Pizza")
    recipe_1.add_ingredient("Cheese", 20)
    recipe_1.add_ingredient("Flour", 20)

    recipe_2 = Recipe.new("Pickles")
    recipe_2.add_ingredient("Brine", 10)
    recipe_2.add_ingredient("Cucumbers", 30)

    recipe_3 = Recipe.new("Peanuts")
    recipe_3.add_ingredient("Raw nuts", 10)
    recipe_3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(recipe_1)
    pantry.add_to_cookbook(recipe_2)
    pantry.add_to_cookbook(recipe_3)

    assert_equal [recipe_1, recipe_2, recipe_3], pantry.cookbook
  end

  def test_it_can_recommend_recipes_based_on_stocked_items
    # skip
    pantry = Pantry.new

    recipe_1 = Recipe.new("Cheese Pizza")
    recipe_1.add_ingredient("Cheese", 20)
    recipe_1.add_ingredient("Flour", 20)

    recipe_2 = Recipe.new("Pickles")
    recipe_2.add_ingredient("Brine", 10)
    recipe_2.add_ingredient("Cucumbers", 30)

    recipe_3 = Recipe.new("Peanuts")
    recipe_3.add_ingredient("Raw nuts", 10)
    recipe_3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(recipe_1)
    pantry.add_to_cookbook(recipe_2)
    pantry.add_to_cookbook(recipe_3)

    assert_equal [recipe_1, recipe_2, recipe_3], pantry.cookbook

    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Cucumbers", 120)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)

    result = ({"Cheese"=>10, "Flour"=>20, "Brine"=>40, "Cucumbers"=>120, "Raw nuts"=>20, "Salt"=>20})
    assert_equal result, pantry.stock

    assert_equal [{"Cheese"=>20, "Flour"=>20}, {"Brine"=>10, "Cucumbers"=>30}, {"Raw nuts"=>10, "Salt"=>10}], pantry.cookbook_ingredients
    assert_equal ["Pickles", "Peanuts"], pantry.what_can_i_make

    # assert_equal {"Pickles" => 4, "Peanuts" => 2}, pantry.how_many_can_i_make
  end
end
