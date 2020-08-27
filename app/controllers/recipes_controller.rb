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
            ref = @recipe.zoom_recipes.where(zoom_schedule_id: @zoom.id).first
            ref.frequency = 0
            ref.save!
        end
        redirect_to "/zoom/list/#{@zoom.uuid}"
    end

    def increment
        zoom = ZoomSchedule.find_by(uuid: params[:uuid])
        
        unless params[:recipe].blank?
            logger.debug(params[:recipe])
            for buf in params.require(:recipe)[:increments] do
                logger.debug(buf)
                recipe = Recipe.find(buf)
                ref = recipe.zoom_recipes.where(zoom_schedule_id: zoom.id).first
                logger.debug(ref)
                ref.frequency += 1
                recipe.frequency += 1
                recipe.save!
                ref.save!
            end
        end
        redirect_to "/zoom/list/#{zoom.uuid}" 
    end

    def index
        @recipes = Recipe.all.order(frequency: "DESC")
    end

    private
    def recipe_params
        params.require(:recipe).permit(:title, :url)
    end

end
