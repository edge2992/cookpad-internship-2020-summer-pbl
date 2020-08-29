# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[
    ["https://entabe.jp/26419/yakitori-can-cheese-dak-galbi-easy-recipe", 10],
    ["https://cookpad.com/recipe/5465688", 3],
    ["http://ainoouchigohan.blog.jp/archives/1065020112.html", 1],
    ["https://www.asahibeer.co.jp/enjoy/recipe/search/recipe.psp.html?CODE=0000001890", 8]
].each do |url, frequency|
    Recipe.create!({url: url, frequency: frequency})
end

