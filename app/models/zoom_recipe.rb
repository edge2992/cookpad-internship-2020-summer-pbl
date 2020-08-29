class ZoomRecipe < ApplicationRecord
    after_initialize :set_default_values
    
    belongs_to :recipe
    belongs_to :zoom_schedule

    validates :frequency, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

    def set_default_values
        self.frequency ||= 0
    end
end
