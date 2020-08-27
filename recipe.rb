class Recipe
  attr_reader :name, :description, :prep_time, :done
  attr_writer :done

  def initialize(recipe = {})
    @name = recipe[:name]
    @description = recipe[:description]
    @prep_time = recipe[:prep_time]
    @done = recipe[:done]
  end
end
