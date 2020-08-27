class View
  def display(recipes)
    recipes.each_with_index do |item, index|
      if item.done == true
        puts "#{index + 1}. [X] #{item.name}: #{item.description} (#{item.prep_time})"
      else
        puts "#{index + 1}. [ ] #{item.name}: #{item.description} (#{item.prep_time})"
      end
    end
  end

  def ask_user_for_name
    puts "What is the name of the recipe you want to add?"
    return gets.chomp
  end

  def ask_user_for_description
    puts "Description of recipe?"
    return gets.chomp
  end

  def ask_user_for_index
    puts "Index?"
    return gets.chomp.to_i
  end

  def ask_user_for_prep_time
    puts "Prep time?"
    return gets.chomp
  end

  def ask_user_for_keyword
    puts "What ingredient would you like a recipe for?"
    keyword = gets.chomp
    sleep 1
    puts "Looking for #{keyword} recipes on the Internet..."
    sleep 1
    return keyword
  end

  def ask_user_for_choice_index(recipes)
    puts "Which recipe would you like to import? (enter index)"
    number = gets.chomp.to_i - 1
    puts "Importing \"#{recipes[number].name}\"..."
    sleep 1
    return number
  end

  def ask_user_mark(recipes)
    puts "what recipe have you completed?"
    number = gets.chomp.to_i - 1
    sleep 1
    puts "Marking \"#{recipes[number].name}\" as done..."
    return number
  end
end
