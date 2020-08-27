# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


recipes = Recipe.create!([{title: "焼き鳥で作るチーズダッカルビ" , url: 'https://entabe.jp/26419/yakitori-can-cheese-dak-galbi-easy-recipe', frequency: 0},
{title: "サバ缶一分おつまみ", url: "https://cookpad.com/recipe/5465688", frequency: 10},
{title: "サバ缶キムチ和え", url: "http://ainoouchigohan.blog.jp/archives/1065020112.html", frequency: 5},
{title: "鯖の味噌煮缶でおろし煮～簡単3stepおつまみ～", url:"https://www.asahibeer.co.jp/enjoy/recipe/search/recipe.psp.html?CODE=0000001890", frequency: 2}])


# 10.times do |i|
#     Recipe.create!({title: "サバ缶#{i}分おつまみ", url: "https://cookpad.com/recipe/5465688", frequency: rand(i)})
# end
