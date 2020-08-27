require_relative "cookbook"
require_relative "recipe"
require_relative "view"
require 'nokogiri'
require 'open-uri'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
  end

  def create
    name = @view.ask_user_for_name
    description = @view.ask_user_for_description
    prep_time = @view.ask_user_for_prep_time

    recipe = Recipe.new(name: name, description: description, prep_time: prep_time)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    display_recipes
    recipe_index = @view.ask_user_for_index
    @cookbook.remove_recipe(recipe_index)
  end

  def import
    keyword = @view.ask_user_for_keyword
    url = "https://www.bbcgoodfood.com/search/recipes?query=#{keyword}"
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')

    bbc_recipes = []
    doc.search('article.node.node-recipe.node-teaser-item.clearfix').each do |element|
      title = element.search('a').text.strip
      description = element.search('div.field-item.even').text.strip
      prep_time = element.search('li.teaser-item__info-item.teaser-item__info-item--total-time').text.strip

      recipe = Recipe.new(name: title, description: description, prep_time: prep_time, done: done)
      bbc_recipes << recipe
    # difficulty = element.search('li.teaser-item__info-item.teaser-item__info-item--skill-level').text.strip
    end
    @view.display(bbc_recipes[0..4])

    number = @view.ask_user_for_choice_index(bbc_recipes)
    recipe = bbc_recipes[number]
    @cookbook.add_recipe(recipe)
  end

  def mark
    display_recipes
    recipes = @cookbook.all
    number = @view.ask_user_mark(recipes)
    recipe = recipes[number]
    recipe.done = true
    @cookbook.store_csv
  end

  def display_recipes
    recipes = @cookbook.all
    @view.display(recipes)
  end
end
