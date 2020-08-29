class ZoomSchedule < ApplicationRecord
    has_many :zoom_recipes
    has_many :recipes, through: :zoom_recipes

    validates :text, presence: true, length: { maximum: 255 }
    validates :uuid, presence: true, uniqueness: true
end
