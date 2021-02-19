# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'
require 'faker'

Dose.destroy_all
Ingredient.destroy_all
Cocktail.destroy_all


ingredients_list_raw = JSON.parse(open('https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list').read)['drinks']
ingredients_list_arr = []

ingredients_list_raw.each do |ingredient|
  ingredients_list_arr << ingredient['strIngredient1']
end


puts 'initializing seeding sequence - Ingredients'
ingredients_list_arr.each do |ingredient|
  Ingredient.create({name: ingredient})
  puts "Ingredient \"#{Ingredient.last.name}\" added with the ID of: #{Ingredient.last.id}"
end

puts 'initializing seeding sequence - cocktails/doses'

3.times do
  Cocktail.create({ name: Faker::Food.dish })
  puts "Cocktail \"#{Cocktail.last.name}\" added with the ID of: #{Cocktail.last.id}"
  3.times do
    Dose.create({
                  description: Faker::Food.measurement,
                  ingredient: Ingredient.find_by({ name: ingredients_list_arr.sample }),
                  cocktail_id: Cocktail.last.id
                })
    puts "Dose \"#{Dose.last.description}\" of \"#{Dose.last.ingredient.name}\" added to its cocktail #{Dose.last.cocktail.name} with the ID of: #{Dose.last.id}"
  end
end

puts 'seeding sequence finished'
