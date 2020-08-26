class ZoomRecipe < ApplicationRecord
    belongs_to :recipe
    belongs_to :zoom_schedule
end
