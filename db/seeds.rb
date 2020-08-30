# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "csv"

CSV.foreach("db/seeds/csv/seed_recipe.csv") do |row|
    Recipe.create(url: row[1], frequency: SecureRandom.random_number(10))
end

CSV.foreach("db/seeds/csv/seed_host.csv") do |row|
    Recipecite.create(host: row[1])
end