class Recipe < ApplicationRecord
    has_many :zoom_recipes
    has_many :zoom_schedules, through: :zoom_recipes

    validates :title, presence: true, length: { maximum: 255 }
    validates :url, presence: true, length: { maximum: 255 }
    validates :frequency, presence: true
end
