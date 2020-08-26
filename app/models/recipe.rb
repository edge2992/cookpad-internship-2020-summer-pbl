class Recipe < ApplicationRecord
    has_many :zoom_recipes
    has_many :zoom_schedules, through: :zoom_recipes
end
