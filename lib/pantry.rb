class Pantry
  attr_reader :stock, :shopping_list, :cookbook

  def initialize
    @stock = Hash.new(0)
    @shopping_list = Hash.new(0)
    @cookbook = []
  end

  def stock_check(item)
    @stock[item]
  end

  def restock(item, quantity)
    @stock[item] += quantity
  end

  def add_to_shopping_list(recipe)
    recipe.ingredients.each do |item, quantity|
      @shopping_list[item] += quantity
    end
  end

  def print_shopping_list
    @shopping_list.map do |item, quantity|
      "* #{item}: #{quantity}"
    end.join("\n")
  end


  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  # def what_can_i_make
  #   things_i_can_make = []
  #   cookbook_ingredients.map.with_index |index, ingredients|
  #     if cookbook_ingredients[index] = @stock
  #       things_i_can_make << @cookbook.name
  #   end
  # end

  def cookbook_ingredients
    @cookbook.map do |recipe|
      recipe.ingredients
    end
  end

end
