class RecipesController < ApplicationController
    def new
        #TODO:: zoomのuuidがないときはnewページに遷移しないように設定する
        @before = Rails.application.routes.recognize_path(request.referer)
    end

    def create
        @recipe = Recipe.new(recipe_params.merge(frequency: 0))
        Recipe.transaction do
            @recipe.save!
            @zoom = ZoomSchedule.find_by(uuid: params[:recipe][:uuid])
            @recipe.zoom_schedules = [@zoom]
        end
        redirect_to "/zoom/list/#{@zoom.uuid}"
    end

    def increment
        for buf in params.require(:recipe)[:increments] do
            logger.debug(buf)
            recipe = Recipe.find(buf)
            recipe.frequency += 1
            recipe.save!
        end

        redirect_to request.referer
    end

    def index
        @recipes = Recipe.all.order(frequency: "DESC")
    end

    private
    def recipe_params
        params.require(:recipe).permit(:title, :url)
    end

end
