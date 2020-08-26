class ZoomRecipe < ApplicationRecord
    belongs_to :recipes
    belongs_to :zoomschedules
end
