class Recipe < ApplicationRecord
    after_initialize :set_default_values
    
    has_many :zoom_recipes
    has_many :zoom_schedules, through: :zoom_recipes

    # validates :title, presence: true, length: { maximum: 255 }
    validates :url, presence: true, uniqueness: true, length: { maximum: 255 }
    validates :frequency, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

    def set_default_values
        self.frequency ||= 0
    end
end
