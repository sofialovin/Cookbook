require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    # csv_options = { col_sep: ',', quote_char: '"'}
    # filepath = 'recipes.csv'
    CSV.foreach(csv_file_path) do |row|
      @recipes << Recipe.new(name: row[0], description: row[1], prep_time: row[2], done: row[3])
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    store_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index.to_i - 1)
    store_csv
  end


  def store_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |item|
        csv << [item.name, item.description, item.prep_time, item.done]
      end
    end
  end
end
