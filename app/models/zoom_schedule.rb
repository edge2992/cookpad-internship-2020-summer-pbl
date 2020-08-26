class ZoomSchedule < ApplicationRecord
    has_many :zoom_recipes
    has_many :recipes, through: :zoom_recipes
    # def to_key
    #     [uuid]
    # end

    # def to_param
    #     uuid
    # end
end
